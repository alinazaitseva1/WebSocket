//
//  UIView+Rounded.swift
//  WebSocketSocializing
//
//  Created by Alina Zaitseva on 11/5/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import Foundation

import UIKit

extension UIView {
    /// Make photo's round shape
    
    func makeRounded() {
        layer.borderWidth = 1.0
        layer.masksToBounds = false
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = frame.size.width / 2
        clipsToBounds = true
    }
}
