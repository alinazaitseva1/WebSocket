//
//  JSONResponce.swift
//  WebSocketSocializing
//
//  Created by Alina Zaitseva on 10/29/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import Foundation

class JSONResponce {
    
    static let onlineStatus = """
    {
        "nickname": "name",
        "date": "Date",
        "is_online": true
        "type": "onlineStatus"
    }
  ]
}
"""
    
    static let typingStatus = """
    {
        "nickname": "name",
        "date": "Date",
        "is_typing": true
        "type": "typingStatus"
  ]
}
"""

    static let sendMessage = """
    {
        "nickname": "name",
        "date": "Date",
        "body":{
            "text": "text",
        "type": "sendMessage"
    }
  ]
}
"""
}
