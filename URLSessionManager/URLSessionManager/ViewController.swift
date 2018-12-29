//
//  ViewController.swift
//  URLSessionManager
//
//  Created by Saddam Husain on 29/12/18.
//  Copyright © 2018 Saddam Husain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        APIManager.getServiceAPI(serviceName: .users)
        let parameters = ["username": "@kilo_loco", "tweet": "HelloWorld"]
//        APIManager.postServiceAPI(serviceName: .posts, dictParams: parameters)
//        APIManager.getServiceAPIWithMultiPart(serviceName: .posts, withParameters: nil, media: nil)
        var  mediaImage = [Media]()
        mediaImage.append(Media(withImage:UIImage.init(named: "demo1.jpeg")!, fileName: "MyImage", forKey: "image")!)
        mediaImage.append(Media(withImage:UIImage.init(named: "demo2.jpg")!, fileName: "MyImage", forKey: "image")!)
        APIManager.postServiceAPIWithMultiPart(serviceName: nil, withParameters: parameters, media: mediaImage)
    }


}

