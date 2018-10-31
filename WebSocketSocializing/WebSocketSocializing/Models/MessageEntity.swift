//
//  MessageEntity.swift
//  WebSocketSocializing
//
//  Created by Alina Zaitseva on 10/30/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import Foundation
import UIKit

struct MessageEntity: Codable {
    
    // MARK: - Vars
    
    var nickname : String!
    var date     : Date!
    var type     : String!
    var body     : TextBody!
    
    private enum CodingKeys: String, CodingKey {
        case nickname
        case date
        case type
        case body
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        nickname = try values.decode(String.self, forKey: .nickname)
        date     = try values.decode(Date.self, forKey: .date)
        type     = try values.decode(String.self, forKey: .type)
        body     = try values.decode(TextBody.self, forKey: .body)
    }
    
//    let data = ChatViewController..data(using: .utf8)!
    let decoder = JSONDecoder()
    
}

struct TextBody: Codable {
    
    // MARK: - Vars
    
    var text : String!
    
    private enum CodingKeys: String, CodingKey {
        
        case text
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        text   = try values.decode(String.self, forKey: .text)
    }
}


