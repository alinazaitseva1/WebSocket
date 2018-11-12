//
//  DateFormatter+Date.swift
//  WebSocketSocializing
//
//  Created by Alina Zaitseva on 10/31/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static let yyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM, HH:mm"
        return formatter
    }()
}
