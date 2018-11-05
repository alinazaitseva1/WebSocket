//
//  CustomColor.swift
//  WebSocketSocializing
//
//  Created by Alina Zaitseva on 11/5/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import Foundation
import UIKit

enum CustomColor {
    
    case grayDefault
    case lightGreenState
    case disabledBlueColor
    
    var color: UIColor {
        switch self {
            
        case .grayDefault:       return UIColor(red: 242, green: 243, blue: 244)
        case .lightGreenState:   return UIColor(red: 216, green: 222, blue: 202)
        case .disabledBlueColor: return UIColor(red: 203, green: 239, blue: 255)

        }
    }
}
