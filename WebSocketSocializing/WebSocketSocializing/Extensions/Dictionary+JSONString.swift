//
//  Dictionary+JSONString.swift
//  WebSocketSocializing
//
//  Created by Alina Zaitseva on 11/1/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import Foundation

// Converting Dictionary to JSON

extension Dictionary {
    
    var json: String {
        let invalidJson = "Not a valid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
    
    func dict2json() -> String {
        return json
    }
}
