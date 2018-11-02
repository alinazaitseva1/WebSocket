//
//  MessageType.swift
//  WebSocketSocializing
//
//  Created by Alina Zaitseva on 11/1/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import Foundation

// Enum to message type in received JSON

enum MessageType: String {
    
    case onlineStatus
    case typingStatus
    case sendMessage
    
}
