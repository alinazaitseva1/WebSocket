//
//  DataError.swift
//  WebSocketSocializing
//
//  Created by Alina Zaitseva on 10/30/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import Foundation

enum DataError: Error, LocalizedError {
    
    case invalidData
    
    var errorDescription: String? {
        switch self {
        case .invalidData:
            return "Invalid data"
        }
    }
}
