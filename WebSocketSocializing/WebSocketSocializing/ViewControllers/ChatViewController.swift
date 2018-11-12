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
    @IBOutlet weak var jumpingView: UIView!
    @IBOutlet weak var inputTextTextField: UITextField!
    @IBOutlet weak var sendMessageButton: ChangeStateButton!
    
    @IBOutlet var jumpingDotsViews: [UIView]!
    @IBOutlet weak var bottomOffsetConstraint: NSLayoutConstraint!
    
    // MARK: - Consts
    
    let minimumSymbolsAmount = 1
    
    // MARK: - Vars
    
    private var socket: WebSocket!
    private var messageText: String {
        return inputTextTextField.text!
    }
    var nickname: String!
    
    private var messagesArray: [MessageEntity] = []
    
    private var typingUsers: Set<String> = [] {
        didSet {
            isTypingView.isHidden = typingUsers.isEmpty
            isTypingUserNameLabel.text = typingUsers.joined(separator: ", ")
        }
    }
    
    // MARK: - Actions
    
    @IBAction func pushSendMessageButtom(_ sender: UIButton) {
        
        let dict: [String : Any] = [ "nickname": nickname,
                                     "date": Date().stringPresentation,
                                     "type": MessageType.sendMessage.rawValue,
                                     "body": [ "text": messageText ] ]
        
        socket.write(data: JSONSerializationHelper.convertToJSONFromDictionary(dict))
        inputTextTextField.text = "" // to clear textfield after message was sent
        sendTypingStatusToSocket(isTyping: false)
    }
    
    // MARK: - Fake data for another user's message imitation
    
    @IBAction func pushAlienMessageButton(_ sender: UIBarButtonItem) {
        
        var randomNames = ["John", "Tyrion", "Cersei", "Bran", "Aria", "Daenerys"]
        let dict: [String : Any] = [ "nickname": randomNames[ Int.random(in: 0 ..< randomNames.count) ],
                                     "date": Date().stringPresentation,
                                     "type": MessageType.sendMessage.rawValue,
                                     "body": [ "text": "blablablablablablabla" ] ]
        
        socket.write(data: JSONSerializationHelper.convertToJSONFromDictionary(dict))
    }
    
    // MARK: - Init functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        socket = WebSocket(url: URL(string: "ws://echo.websocket.org")!)
        socket.delegate = self
        socket.connect()
        noConnectionView.isHidden = true
        isTypingView.isHidden = true
        
        setupViewResizerOnKeyboardShown()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        for (index, jumpingDotView) in self.jumpingDotsViews.enumerated() {
            jumpingDotView.makeRounded()
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index)/10) {
                UIView.animate(withDuration: 0.5,
                               delay: 0.4,
                               options: [.repeat, .autoreverse],
                               animations: { jumpingDotView.center.y += self.jumpingView.bounds.height },
                               completion: nil
                )
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        if self.isMovingFromParent {
            sendOnlineStatusToSocket(isOnline: false)
        }
    }
    
    deinit {
        socket.disconnect()
    }
    
    // MARK: - WebSocketDelegate functions
    
    func websocketDidConnect(socket: WebSocketClient) {
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("websocket is disconnected: \(String(describing: error?.localizedDescription))")
        noConnectionView.isHidden = false
        isTypingView.isHidden = true
        inputTextView.isHidden = true
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) { }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        
        guard let receivedDictionary = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] else { return }
        
        if MessageType.sendMessage.rawValue == receivedDictionary["type"] as? String {
            let message = MessageEntity(dictionary: receivedDictionary)
            messagesArray.append(message!)
            
            uiTableView.insertRows(at: [IndexPath(row: messagesArray.count - 1, section: 0)], with: UITableView.RowAnimation.left)
            uiTableView.scrollToRow(at: IndexPath(row: messagesArray.count - 1, section: 0), at: UITableView.ScrollPosition.bottom, animated: true)
        }
        
        if MessageType.typingStatus.rawValue == receivedDictionary["type"] as? String {
            
            if let nickName = receivedDictionary["nickname"] as? String {
                
                if receivedDictionary["is_typing"] as? Bool == true {
                    typingUsers.insert(nickName)
                    
                } else if typingUsers.contains(nickName) {
                    typingUsers.remove(nickName)
                }
            }
        }
    }
    
    // MARK: - Network function
    
    private func sendTypingStatusToSocket(isTyping: Bool) {
        
        let dict: [String : Any] = [ "nickname": nickname,
                                     "date": Date().stringPresentation,
                                     "type": MessageType.typingStatus.rawValue,
                                     "is_typing": isTyping
        ]
        
        socket.write(data: JSONSerializationHelper.convertToJSONFromDictionary(dict))
    }
    
    private func sendOnlineStatusToSocket(isOnline: Bool) {
        
        let dict: [String : Any] = [ "nickname": nickname,
                                     "date": Date().stringPresentation,
                                     "type": MessageType.onlineStatus.rawValue,
                                     "is_online": isOnline
        ]
        socket.write(data: JSONSerializationHelper.convertToJSONFromDictionary(dict))
    }
    
    // MARK: - TextField function
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        
        let symbolsInField = sender.text?.count ?? 0
        
        if symbolsInField == minimumSymbolsAmount {
            sendTypingStatusToSocket(isTyping: true)
            
        } else if symbolsInField == 0 {
            sendTypingStatusToSocket(isTyping: false)
        }
        
        // Turning on/off send button
        sendMessageButton.isEnabled = messageText.count >= minimumSymbolsAmount
    }
    
    // MARK: - Keyboard function
    
    func setupViewResizerOnKeyboardShown() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            bottomOffsetConstraint.constant = 0
            
        } else {
            
            let keyboardScreenEndFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            bottomOffsetConstraint.constant = keyboardScreenEndFrame.height
        }
    }
}

// MARK: - Extension tableView UITableViewDelegate, UITableViewDataSource

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let messageTableViewCell = uiTableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as! MessageTableViewCell
        
        let sms = messagesArray[indexPath.row]
        messageTableViewCell.configureWith(message: sms) 
        
        if nickname == sms.nickname {
            
            messageTableViewCell.setUpMessageAppearence(at: .left)
        } else {
            
            messageTableViewCell.setUpMessageAppearence(at : .right)
            isTypingView.isHidden = true
        }
        
        return messageTableViewCell
    }
}
