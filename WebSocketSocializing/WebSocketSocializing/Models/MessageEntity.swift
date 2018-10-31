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

extension MessageEntity {
    
    init(dictionary: Dictionary<String, Any>) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.init())
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        //self = decoder.decode(MessageEntity.self, from: )
        
    }
}

extension JSONDecoder {
    
    func decode(type: Decodable, from dictionary: Dictionary<String, Any>) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted) // 
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
    
    struct TextBody: Codable {
        
        // MARK: - Vars
        
        var text : String!
        
}

