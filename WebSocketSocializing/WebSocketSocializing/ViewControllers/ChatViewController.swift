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
    @IBOutlet weak var isTypingUserName: UILabel!
    @IBOutlet weak var inputTextView: UIView!
    @IBOutlet weak var showTypingView: UIView!
    @IBOutlet weak var InputTextTextField: UITextField!
    @IBOutlet weak var sendMessageButton: ChangeStateButton!
    
    // MARK: - Vars
    
    var socket: WebSocket!
    private var messageText: String {
        return InputTextTextField.text!
    }
    var nickname: String!
    
    // MARK: - Consts
    
    static let messageDictionary : [String: Any] = [ "nickname":"name", "date":"2018-09-21T12:45:12","type":"sendMessage","body": [ "text": "Test Message" ] ]
    
    let mes = MessageEntity(dictionary: ChatViewController.messageDictionary)
    
    // MARK: - Actions
    
    @IBAction func pushSendMessageButtom(_ sender: UIButton) {
        // TODO: - Create json from text(TextField) -> Model -> Array
        
        _ = MessageEntity(nickname: nickname, date: Date(), type: MessageType.sendMessage.rawValue, body: TextBody(text: messageText))
        
        let dict: [String : Any] = [ "nickname": nickname,
        "date": "2018-09-21T12:45:12",
        "type": MessageType.sendMessage.rawValue,
        "body": [ "text": messageText ] ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [])
        
        socket.write(data: jsonData!)
    }
    
    // MARK: - Init functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        socket = WebSocket(url: URL(string: "ws://echo.websocket.org")!)
        socket.delegate = self
        socket.connect()
    }
    
    // - WebSocketDelegate functions
    
    func websocketDidConnect(socket: WebSocketClient) {
        print("websocket is connected")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("websocket is disconnected: \(String(describing: error?.localizedDescription))")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("got some text: \(text)")
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("got some data: \(data.count)")
        let receivedDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        if let type = receivedDictionary?[MessageType.sendMessage.rawValue] {
            // HERE
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
        return 1 // return arrayOfMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let messageTableViewCell = uiTableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as! MessageTableViewCell
        messageTableViewCell.messageLabel.layer.masksToBounds = true
        messageTableViewCell.messageLabel.layer.cornerRadius = 8
        
        messageTableViewCell.createdLabel.text = mes?.date.stringPresentation
        messageTableViewCell.messageLabel.text = mes?.body.text
        messageTableViewCell.userNameLabel.text = mes?.nickname
        
        return messageTableViewCell
    }
}
