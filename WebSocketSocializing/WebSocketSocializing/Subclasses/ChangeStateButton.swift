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
                self.setTitleColor(CustomColor.disabledBlueColor.color, for: .normal)
                
            } else {
                self.setTitleColor(CustomColor.lightGreenState.color, for: .normal)
            }
            super.isEnabled = newValue
        }
    }
    
}
