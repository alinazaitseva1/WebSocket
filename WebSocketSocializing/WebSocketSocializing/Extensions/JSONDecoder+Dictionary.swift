//
//  JSONDecoder+Dictionary.swift
//  WebSocketSocializing
//
//  Created by Alina Zaitseva on 10/31/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import Foundation

// - Extension to decode dictionary as data

extension JSONDecoder {
    
    func decode<T>(_ type: T.Type, from dictionary: Dictionary<String, Any>) throws -> T where T : Decodable {
        let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        return try decode(type, from: jsonData)
    }
}
