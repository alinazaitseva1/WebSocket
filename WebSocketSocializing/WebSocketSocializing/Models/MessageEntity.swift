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
}

// MARK: - for converting data to dictionary

extension MessageEntity {
    
    init?(dictionary: Dictionary<String, Any>) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.yyMMdd)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        if let decodedObject = try? decoder.decode(MessageEntity.self, from: dictionary) {
            self = decodedObject
        } else {
            return nil
        }
    }
}

struct TextBody: Codable {
    
    // MARK: - Vars
    
    var text : String!
    
}
