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
    
    @IBOutlet private weak var messageContainerView: UIView!
    @IBOutlet private weak var messageView: UIView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var createdLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    
    public func configureWith(message: MessageEntity) {
        
        userNameLabel.text = message.nickname
        createdLabel.text = message.date.stringPresentation
        messageLabel.text = message.body.text
        
        messageView.layer.masksToBounds = true
        messageView.layer.cornerRadius = 16
        
    }
    
    public func setUpMessageAppearence(at textAlignment: NSTextAlignment) {
        switch textAlignment {
        case .left:
            messageView.backgroundColor = CustomColor.grayDefault.color
            messageContainerView.flipX()
            contentView.flipX()
        case .right:
            messageView.backgroundColor = CustomColor.disabledBlueColor.color
            messageContainerView.transform = .identity
            contentView.transform = .identity
        default:
            break
        }
        userNameLabel.textAlignment = textAlignment
        createdLabel.textAlignment = textAlignment
    }
}
