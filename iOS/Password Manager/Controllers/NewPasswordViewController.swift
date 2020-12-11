//
//  NewPasswordViewController.swift
//  Password Manager
//
//  Created by Álvaro Santillan on 12/10/20.
//  Copyright © 2020 Álvaro Santillan. All rights reserved.
//

import UIKit

class NewPasswordViewController: UIViewController, UITextFieldDelegate  {
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var retypeNewPasswordTextField: UITextField!
    @IBOutlet weak var passwordFeedbackLabel: UILabel!
    @IBOutlet weak var setPasswordButton: GeneralUIButton!
    
    var newPasswordPassed: Bool = false
    var passwordVirificationPassed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        self.newPasswordTextField.delegate = self
        self.retypeNewPasswordTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    // To-do: Should probilby fail user if spaces are used in the new password.
    // To-do: Should improve password requirements.
    @IBAction func newPasswordTextFieldPressed(_ sender: UITextField) {
        // Remove leading and trailing whitespaces.
        let newPasswordText = newPasswordTextField.text?.trimmingCharacters(in: .whitespaces)
        
        // New password must be at least 8 charactors.
        if newPasswordText?.count ?? 0 < 8 {
            newPasswordPassed = false
            newPasswordTextField.layer.borderWidth = 1
            newPasswordTextField.layer.borderColor = UIColor.red.cgColor
            passwordFeedbackLabel.text = "New password should be 8+ characters long."
        } else if newPasswordTextField.text == nil || newPasswordTextField.text == "" {
            newPasswordTextField.layer.borderWidth = 0
        } else {
            if passwordFeedbackLabel.text == "New password should be 8+ characters long." {
                passwordFeedbackLabel.text = nil
            }
            newPasswordPassed = true
            newPasswordTextField.layer.borderWidth = 1
            newPasswordTextField.layer.borderColor = UIColor.green.cgColor
        }
        // Update other parts of the UI to update.
        retypeNewPasswordTextFieldPressed(retypeNewPasswordTextField)
        updateSetPasswordButtonStatus()
    }

    @IBAction func retypeNewPasswordTextFieldPressed(_ sender: UITextField) {
        // Remove leading and trailing whitespaces.
        let newPasswordText = newPasswordTextField.text?.trimmingCharacters(in: .whitespaces)
        let retypeNewPasswordText = retypeNewPasswordTextField.text?.trimmingCharacters(in: .whitespaces)

        // Varify new passwords match.
        if newPasswordText != retypeNewPasswordText {
            passwordVirificationPassed = false
            retypeNewPasswordTextField.layer.borderWidth = 1
            retypeNewPasswordTextField.layer.borderColor = UIColor.red.cgColor
            passwordFeedbackLabel.text = "New passwords dont match."
        } else if newPasswordText == "" {
            retypeNewPasswordTextField.layer.borderWidth = 0
        } else {
            if passwordFeedbackLabel.text == "New passwords dont match." {
                passwordVirificationPassed = true
                retypeNewPasswordTextField.layer.borderWidth = 1
                retypeNewPasswordTextField.layer.borderColor = UIColor.green.cgColor
                passwordFeedbackLabel.text = nil
            }
        }
        // Update other parts of the UI to update.
        updateSetPasswordButtonStatus()
    }
    
    @IBAction func setPasswordButtonPressed(_ sender: GeneralUIButton) {
        // If all requirements for a new password are met.
        if canChangePassword() {
            // Update the password.
            let newPassword = newPasswordTextField.text?.trimmingCharacters(in: .whitespaces)
            KeychainWrapper.standard.set(newPassword!, forKey: "Password")
            
            // Update The UI.
            setPasswordButton.isEnabled = false
            setPasswordButton.backgroundColor = UIColor.gray
            newPasswordTextField.text = nil
            retypeNewPasswordTextField.text = nil
            newPasswordTextField.layer.borderWidth = 0
            retypeNewPasswordTextField.layer.borderWidth = 0
            self.performSegue(withIdentifier: "firstPasswordSetSegue", sender: nil)
        }
    }
    
    func updateSetPasswordButtonStatus() {
        // Handle enabiling and disabiling the set password button.
        if newPasswordPassed && passwordVirificationPassed {
            setPasswordButton.isEnabled = true
            setPasswordButton.backgroundColor = UIColor(named: "Webroot")
        } else {
            setPasswordButton.isEnabled = false
            setPasswordButton.backgroundColor = UIColor.gray
        }
    }
    
    func canChangePassword() -> Bool {
        newPasswordPassed && passwordVirificationPassed ? true : false
    }
}
