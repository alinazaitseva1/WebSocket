//
//  Date+String.swift
//  WebSocketSocializing
//
//  Created by Alina Zaitseva on 10/31/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import Foundation

extension Date {
    
    var stringPresentation: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM, HH:mm"
        return dateFormatter.string(from: self)
    }
}
