//
//  Constans.swift
//  URLSessionManager
//
//  Created by Saddam Husain on 29/12/18.
//  Copyright © 2018 Saddam Husain. All rights reserved.
//

import Foundation

enum URLEndPoints :String{
    case users = "users"
    case posts = "posts"
}

struct ServerURL {
    
    var baseURL = "https://jsonplaceholder.typicode.com/"
    
    func makeFullURL(serviceName:URLEndPoints) -> String {

        switch serviceName{
        case.users:
            return baseURL + serviceName.rawValue
        case.posts:
            return baseURL + serviceName.rawValue
        }
    }
}


