//
//  RegistrationViewController.swift
//  WebSocketSocializing
//
//  Created by Alina Zaitseva on 10/30/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var inputNameTextField: UITextField!
    @IBOutlet weak var okButton: ChangeStateButton!
    
    // MARK: - Vars
    
    var nickname: String {
        return inputNameTextField.text!
    }
    
    // MARK: - Actions
    
    @IBAction func pushOkButton(_ sender: UIButton) {
        let chatStoryboard = UIStoryboard(name: "Chat", bundle: nil)
        let chatVC = chatStoryboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        chatVC.nickname = self.nickname // delegate to past nickname to chat vc
        self.navigationController?.pushViewController(chatVC, animated: true)
    
        UserDefaults.standard.set(nickname, forKey: nickname)
    }
    
    // MARK: - Init function
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - TextField function
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        // Turning on/off ok button
        okButton.isEnabled = nickname.count >= minimumSymbolsAmount
    }
}
