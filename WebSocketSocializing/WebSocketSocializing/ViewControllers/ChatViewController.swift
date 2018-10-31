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
    
    // MARK: - Outlets
    
    
    @IBOutlet weak var uiTableView: UITableView!
    
    @IBOutlet weak var noConnectionView: UIView!
    @IBOutlet weak var isTypingView: UIView!
    @IBOutlet weak var isTypingUserName: UILabel!
    @IBOutlet weak var inputTextView: UIView!
    @IBOutlet weak var showTypingView: UIView!
    @IBOutlet weak var InputTextTextField: UITextField!
    @IBOutlet weak var sendMessageButton: UIButton!
    
    // MARK: - Vars
    
    let message = MessageEntity(dictionary: ChatViewController.messageDictionary)
    
    // MARK: - Const
    
    static let messageDictionary : [String: Any] = [ "nickname":"name", "date":"2018-09-21T12:45:12","type":"sendMessage","body": [ "text": "Test Message" ] ]
    
    // MARK: - Actions
    
    @IBAction func pushSendMessageButtom(_ sender: UIButton) {
        
    }
    
    // MARK: - Init function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(message)
    }
    
}

// MARK: - Extension

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 //?
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let messageTableViewCell = uiTableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as! MessageTableViewCell
        return messageTableViewCell
    }
    
    
    
    
}
