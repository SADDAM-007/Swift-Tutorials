//
//  APIManager.swift
//  URLSessionManager
//
//  Created by Saddam Husain on 29/12/18.
//  Copyright © 2018 Saddam Husain. All rights reserved.
//

import Foundation

class APIManager: NSObject {
    
    static func getServiceAPI(serviceName:URLEndPoints){
       let urlString = ServerURL().makeFullURL(serviceName: serviceName)
       let urlType = URL(string: urlString)
        guard let url = urlType else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
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
        let urlType = URL(string: urlString)
        guard let url = urlType else { return }
        var request = URLRequest(url: url)
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
}
