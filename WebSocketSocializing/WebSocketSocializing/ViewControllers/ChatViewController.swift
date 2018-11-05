//
//  ViewController.swift
//  WebSocketSocializing
//
//  Created by Alina Zaitseva on 10/29/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import UIKit
import Starscream


class ChatViewController: UIViewController, WebSocketDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var uiTableView: UITableView!
    
    @IBOutlet weak var noConnectionView: UIView!
    @IBOutlet weak var isTypingView: UIView!
    @IBOutlet weak var isTypingUserNameLabel: UILabel!
    @IBOutlet weak var inputTextView: UIView!
    @IBOutlet weak var showTypingView: UIView!
    @IBOutlet weak var inputTextTextField: UITextField!
    @IBOutlet weak var sendMessageButton: ChangeStateButton!
    
    // MARK: - Vars
    
    var socket: WebSocket!
    private var messageText: String {
        return inputTextTextField.text!
    }
    var nickname: String!
    var messagesArray: [MessageEntity] = [] {
        didSet{
            uiTableView.reloadData()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func pushSendMessageButtom(_ sender: UIButton) {
        
        let dict: [String : Any] = [ "nickname": nickname,
                                     "date": "2018-09-21T12:45:12",
                                     "type": MessageType.sendMessage.rawValue,
                                     "body": [ "text": messageText ] ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [])
        
        socket.write(data: jsonData!)
        inputTextTextField.text = "" // to clear textfield after message was sent
        UserDefaults.standard.set(nickname, forKey: nickname)
    }
    
    // MARK: - Someone else's message imitation
    
    @IBAction func pushAlienMessage(_ sender: UIBarButtonItem) {
        
        let dict: [String : Any] = [ "nickname": "John",
                                     "date": "2018-09-21T12:45:12",
                                     "type": MessageType.sendMessage.rawValue,
                                     "body": [ "text": "Blablablablablabla bla" ] ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [])
        
        socket.write(data: jsonData!)
        UserDefaults.standard.removeObject(forKey: nickname)
    }
    
    
    // MARK: - Init functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        socket = WebSocket(url: URL(string: "ws://echo.websocket.org")!)
        socket.delegate = self
        socket.connect()
        noConnectionView.isHidden = true
        isTypingView.isHidden = true
    }
    
    deinit {
        socket.disconnect()
    }
    
    // - WebSocketDelegate functions
    
    func websocketDidConnect(socket: WebSocketClient) {
        print("websocket is connected")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("websocket is disconnected: \(String(describing: error?.localizedDescription))")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) { }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("got some data: \(data.count)")
        let receivedDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        if MessageType.sendMessage.rawValue == receivedDictionary?["type"] as? String {
            let message = MessageEntity(dictionary: receivedDictionary!)
            messagesArray.append(message!)
        }
    }
    
    // MARK: - TextField function
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        // Turning on/off send button
        sendMessageButton.isEnabled = messageText.count >= minimumSymbolsAmount
    }
}

// MARK: - Extension table view UITableViewDelegate, UITableViewDataSource

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let messageTableViewCell = uiTableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as! MessageTableViewCell
        messageTableViewCell.messageView.layer.masksToBounds = true
        messageTableViewCell.messageView.layer.cornerRadius = 16
        let sms = messagesArray[indexPath.row]
        
        messageTableViewCell.createdLabel.text = sms.date.stringPresentation
        messageTableViewCell.messageLabel.text = sms.body.text
        messageTableViewCell.userNameLabel.text = sms.nickname
        
        if UserDefaults.standard.string(forKey: nickname) == nickname {
            
            messageTableViewCell.messageView.backgroundColor = CustomColor.grayDefault.color
            messageTableViewCell.messageContainerView.flipX()
            //messageTableViewCell.messageView.translatesAutoresizingMaskIntoConstraints = false
            //[viewA removeConstraint:self.myViewsLeftConstraint];
            // TODO: - create outlets from constraints 
            //messageTableViewCell.messageView.leftAnchor.constraint(equalTo: messageTableViewCell.messageContainerView.leftAnchor).isActive = true
        }
        
        return messageTableViewCell
    }
}
