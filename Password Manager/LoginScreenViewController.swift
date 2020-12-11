//
//  LoginScreenViewController.swift
//  Password Manager
//
//  Created by Álvaro Santillan on 12/8/20.
//  Copyright © 2020 Álvaro Santillan. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginScreenViewController: UIViewController {
    @IBOutlet weak var unlockButton: UIButton!
    @IBOutlet weak var passwordEntryTextField: UITextField!
    @IBOutlet weak var feedBackLabel: UILabel!
    @IBOutlet weak var bioUnlockButton: GeneralUIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(KeychainWrapper.standard.string(forKey: "Password"))
        
        let context = LAContext()
        var error: NSError?
        
        if !(context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)) {
            // no biometrics on phone desable bio button
            bioUnlockButton.isHidden = true
        }
    }
    
    @IBAction func unlockButtonPressed(_ sender: Any) {
        if KeychainWrapper.standard.string(forKey: "Password") == nil {
            self.performSegue(withIdentifier: "newPasswordSegue", sender: nil)
        } else if passwordEntryTextField.text != KeychainWrapper.standard.string(forKey: "Password") {
            feedBackLabel.text = "Wrong Password, Try Agien"
            passwordEntryTextField.text = nil
        } else {
            self.performSegue(withIdentifier: "unlockSegue", sender: nil)
        }
    }
    
    @IBAction func bioUnlockButtonPressed(_ sender: GeneralUIButton) {
        if KeychainWrapper.standard.string(forKey: "Password") == nil {
            self.performSegue(withIdentifier: "newPasswordSegue", sender: nil)
        } else {
            unlockUsingBiometrics()
        }
    }
    
    func unlockUsingBiometrics() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "To Unlock, Please varify its you"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self?.performSegue(withIdentifier: "unlockSegue", sender: nil)
                    }
                }
            }
        } else {
            // no biometrics on phone
            let ac = UIAlertController(title: "Bio unavaliable", message: "not avalable on your phone", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
}
