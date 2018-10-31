//
//  ApiResponce.swift
//  WebSocketSocializing
//
//  Created by Alina Zaitseva on 10/30/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import Foundation

class ApiResponse {
    
    func getData(from dictionary: String, completion: @escaping (MessageEntity) -> Void) {
        
//        let messageDictionary : [String: Any] = [ "nickname":"name", "date":"2018-09-21T12:45:12","type":"sendMessage","body": [ "text": "Test Message" ], ]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: ChatViewController.messageDictionary, options: [])
            let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)!
            print (jsonString)
        }
        catch {
            print(DataError.invalidData.errorDescription!)
        }
    }
}
