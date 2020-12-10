//
//  LoginScreenViewController.swift
//  Password Manager
//
//  Created by Álvaro Santillan on 12/8/20.
//  Copyright © 2020 Álvaro Santillan. All rights reserved.
//

import UIKit

class LoginScreenViewController: UIViewController {
    @IBOutlet weak var unlockButton: UIButton!
    @IBOutlet weak var passwordEntryTextField: UITextField!
    @IBOutlet weak var feedBackLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func unlockButtonPressed(_ sender: Any) {
        print(KeychainWrapper.standard.string(forKey: "Password"))
        
        if KeychainWrapper.standard.string(forKey: "Password") == nil {
            self.performSegue(withIdentifier: "newPasswordSegue", sender: nil)
        } else if passwordEntryTextField.text != KeychainWrapper.standard.string(forKey: "Password") {
            feedBackLabel.text = "Wrong Password, Try Agien"
            passwordEntryTextField.text = nil
        } else {
            self.performSegue(withIdentifier: "unlockSegue", sender: nil)
        }
    }
}
