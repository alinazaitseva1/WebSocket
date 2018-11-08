//
//  MessageTableViewCell.swift
//  WebSocketSocializing
//
//  Created by Alina Zaitseva on 10/30/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var messageContainerView: UIView!
    @IBOutlet weak var messageView: UIView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    
    public func configureWith(message: MessageEntity) {
        
        userNameLabel.text = message.nickname
        createdLabel.text = message.date.stringPresentation
        messageLabel.text = message.body.text
        messageView.layer.masksToBounds = true
        messageView.layer.cornerRadius = 16
        userNameLabel.textAlignment = .left
        createdLabel.textAlignment = .left
        messageContainerView.flipX()
        contentView.flipX()
        messageView.backgroundColor = CustomColor.grayDefault.color
    }
}
