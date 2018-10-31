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
    
    // MARK: - Actions
    
    @IBAction func pushOkButton(_ sender: UIButton) {
        let chatStoryboard = UIStoryboard(name: "Chat", bundle: nil)
        let chatVC = chatStoryboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        self.navigationController?.pushViewController(chatVC, animated: true)
    }
    
    // MARK: - Vars
    
    
    // MARK: - Init function

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
