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
        transform = CGAffineTransform(scaleX: -transform.a, y: transform.d)
    }
    
    /// Flip view vertically.
    func flipY() {
        transform = CGAffineTransform(scaleX: transform.a, y: -transform.d)
    }
}
