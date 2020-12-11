//
//  LoginScreenViewController.swift
//  Password Manager
//
//  Created by Álvaro Santillan on 12/8/20.
//  Copyright © 2020 Álvaro Santillan. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginScreenViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var unlockButton: UIButton!
    @IBOutlet weak var passwordEntryTextField: UITextField!
    @IBOutlet weak var feedBackLabel: UILabel!
    @IBOutlet weak var bioUnlockButton: GeneralUIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        checkIfBiometricsAreEnabled()
        
        self.passwordEntryTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func checkIfBiometricsAreEnabled() {
        let context = LAContext()
        var error: NSError?
        
        // If no biometrics on the phone desable the biomentrics unlock button.
        if !(context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)) {
            bioUnlockButton.isHidden = true
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
        }
    }
    
    @IBAction func unlockButtonPressed(_ sender: Any) {
        if KeychainWrapper.standard.string(forKey: "Password") == nil {
            // First run setup new password.
            self.performSegue(withIdentifier: "newPasswordSegue", sender: nil)
        } else if passwordEntryTextField.text != KeychainWrapper.standard.string(forKey: "Password") {
            // Password failed
            feedBackLabel.text = "Wrong Password, Try Agien"
            passwordEntryTextField.text = nil
        } else {
            // Password passed
            self.performSegue(withIdentifier: "unlockSegue", sender: nil)
        }
    }
    
    @IBAction func bioUnlockButtonPressed(_ sender: GeneralUIButton) {
        if KeychainWrapper.standard.string(forKey: "Password") == nil {
            // First run setup new password.
            self.performSegue(withIdentifier: "newPasswordSegue", sender: nil)
        } else {
            // Password passed
            unlockUsingBiometrics()
        }
    }
}
