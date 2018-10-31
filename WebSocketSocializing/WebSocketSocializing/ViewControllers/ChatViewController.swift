//
//  ViewController.swift
//  WebSocketSocializing
//
//  Created by Alina Zaitseva on 10/29/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import UIKit
import Starscream


class ChatViewController: UIViewController {
    
    // MARK: - Vars
    
    var messages: MessageEntity!
    

    // MARK: - Const
    
    static let messageDictionary : [String: Any] = [ "nickname":"name", "date":"2018-09-21T12:45:12","type":"sendMessage","body": [ "text": "Test Message" ], ]
    
    
    // MARK: - Init function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
     // MARK: - Functions
    
    
    
    
}
