//
//  ChangeStateButton.swift
//  WebSocketSocializing
//
//  Created by Alina Zaitseva on 11/1/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import UIKit

class ChangeStateButton: UIButton {
    
    override var isEnabled: Bool {
        get {
            return super.isEnabled
        }
        set {
            if newValue == true {
                self.backgroundColor = .gray
                self.layer.borderWidth = 1
            } else {
                self.backgroundColor = .red
                self.layer.borderWidth = 1
            }
            super.isEnabled = newValue
        }
    }
    
}
