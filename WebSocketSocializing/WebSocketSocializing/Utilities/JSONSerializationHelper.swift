//
//  JSONSerializationHelper.swift
//  WebSocketSocializing
//
//  Created by Alina Zaitseva on 11/8/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import Foundation

class JSONSerializationHelper {
    
    static func convertToJSONFromDictionary(_ dictionary: [String: Any]) -> Data {
        return try! JSONSerialization.data(withJSONObject: dictionary, options: [])
    }
}
