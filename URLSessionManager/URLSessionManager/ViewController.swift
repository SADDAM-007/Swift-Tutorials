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
        // Do any additional setup after loading the view, typically from a nib.
        //APIManager.getServiceAPI(serviceName: .users)
        let parameters = ["username": "@kilo_loco", "tweet": "HelloWorld"]
        APIManager.postServiceAPI(serviceName: .post, dictParams: parameters)
    }


}

