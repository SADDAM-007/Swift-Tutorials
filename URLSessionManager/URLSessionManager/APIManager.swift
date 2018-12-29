//
//  APIManager.swift
//  URLSessionManager
//
//  Created by Saddam Husain on 29/12/18.
//  Copyright © 2018 Saddam Husain. All rights reserved.
//

import UIKit

class APIManager: NSObject {
    
    static func getServiceAPI(serviceName:URLEndPoints){
       let urlString = ServerURL().makeFullURL(serviceName: serviceName)
        let session = URLSession.shared
        session.dataTask(with: URL(string: urlString)!) { (data, response, error) in
//            if let response = response {
//                print(response)
//            }
            if let data = data {
                print(data)
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
            }.resume()
    }
    
    
   static func postServiceAPI(serviceName:URLEndPoints,dictParams :[String:Any]) {

        let urlString = ServerURL().makeFullURL(serviceName: serviceName)
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: dictParams, options: []) else { return }
        request.httpBody = httpBody
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
//            if let response = response {
//                print(response)
//            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
            
            }.resume()
    }
    
    // #MARK: Multi-part/form-data
    
   static func getServiceAPIWithMultiPart(serviceName:URLEndPoints,withParameters params: [String:String]?, media: [Media]?) {
        
        let urlString = ServerURL().makeFullURL(serviceName: serviceName)
        var request = URLRequest(url: URL(string: urlString)!)
        let boundary = generateBoundary()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let dataBody = createDataBody(withParameters: params, media: media, boundary: boundary)
        request.httpBody = dataBody
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
//            if let response = response {
//                print(response)
//            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
            }.resume()
        
    }
    
    
   static func postServiceAPIWithMultiPart(serviceName:URLEndPoints?,withParameters params: [String:String]?, media: [Media]?) {

    //    let urlString = ServerURL().makeFullURL(serviceName: serviceName)
    //    var request = URLRequest(url: URL(string: urlString)!)
        guard let url = URL(string: "https://api.imgur.com/3/image") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = generateBoundary()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("Client-ID f65203f7020dddc", forHTTPHeaderField: "Authorization")
        
        let dataBody = createDataBody(withParameters: params, media: media, boundary: boundary)
        request.httpBody = dataBody
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
//            if let response = response {
//                print(response)
//            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
            }.resume()
    }
    
   class func createDataBody(withParameters params: [String:String]?, media: [Media]?, boundary: String) -> Data {
        
        let lineBreak = "\r\n"
        var body = Data()
        
        if let parameters = params {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value + lineBreak)")
            }
        }
        
        if let media = media {
            for photo in media {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
                body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
                body.append(photo.data)
                body.append(lineBreak)
            }
        }
        
        body.append("--\(boundary)--\(lineBreak)")
        
        return body
    }
    
    class func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
}

struct Media {
    let key: String
    let filename: String
    let data: Data
    let mimeType: String
    
    init?(withImage image: UIImage,fileName :String ,forKey key: String) {
        self.key = key
        self.mimeType = "image/jpeg"
        self.filename = "\(fileName).jpg"
        
        guard let data = image.jpegData(compressionQuality: 0.8) else { return nil }
        self.data = data
    }
}
extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
