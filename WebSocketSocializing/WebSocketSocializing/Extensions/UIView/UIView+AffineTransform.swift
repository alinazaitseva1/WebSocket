//
//  UIView+Mirror.swift
//  WebSocketSocializing
//
//  Created by Alina Zaitseva on 11/5/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Flip view horizontally.
    func flipX() {
        transform = .identity
        transform = CGAffineTransform(scaleX: -1, y: 1)
    }
}
