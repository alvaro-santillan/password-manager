//
//  SettingsViewController.swift
//  Password Manager
//
//  Created by Álvaro Santillan on 12/8/20.
//  Copyright © 2020 Álvaro Santillan. All rights reserved.
//

import UIKit

// To-do: Should sign out when switched to another app.
class SettingsViewController: UIViewController, UITextFieldDelegate  {
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var retypeNewPasswordTextField: UITextField!
    @IBOutlet weak var passwordFeedbackLabel: UILabel!
    @IBOutlet weak var changePasswordButton: GeneralUIButton!
    
    var oldPasswordPassed: Bool = false
    var newPasswordPassed: Bool = false
    var passwordVirificationPassed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        changePasswordButton.isEnabled = false
        changePasswordButton.backgroundColor = UIColor.gray
        
        self.oldPasswordTextField.delegate = self
        self.newPasswordTextField.delegate = self
        self.retypeNewPasswordTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func oldPasswordTextFieldPressed(_ sender: UITextField) {
        if oldPasswordTextField.text == KeychainWrapper.standard.string(forKey: "Password") || KeychainWrapper.standard.string(forKey: "Password") == nil {
            oldPasswordPassed = true
            oldPasswordTextField.layer.borderWidth = 1
            oldPasswordTextField.layer.borderColor = UIColor.green.cgColor
        } else if oldPasswordTextField.text == nil || oldPasswordTextField.text == "" {
            oldPasswordTextField.layer.borderWidth = 0
        } else {
            oldPasswordPassed = false
            oldPasswordTextField.layer.borderWidth = 1
            oldPasswordTextField.layer.borderColor = UIColor.red.cgColor
        }
        updatePasswordButtonStatus()
    }

    // To-do: Should probilby fail user if spaces are used in the new password.
    // To-do: Should improve password requirements.
    // To-do: This code is duplicated in NewPasswordViewController.
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
        updatePasswordButtonStatus()
    }

    // To-do: This code is duplicated in NewPasswordViewController.
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
        updatePasswordButtonStatus()
    }
    
    // To-do: This code is duplicated in NewPasswordViewController.
    @IBAction func updatePasswordButtonPressed(_ sender: GeneralUIButton) {
        // If all requirements for a new password are met.
        if canChangePassword() {
            // Update the password.
            let newPassword = newPasswordTextField.text?.trimmingCharacters(in: .whitespaces)
            KeychainWrapper.standard.set(newPassword!, forKey: "Password")
            
            // Update The UI.
            changePasswordButton.isEnabled = false
            changePasswordButton.backgroundColor = UIColor.gray
            oldPasswordTextField.text = nil
            newPasswordTextField.text = nil
            retypeNewPasswordTextField.text = nil
            oldPasswordTextField.layer.borderWidth = 0
            newPasswordTextField.layer.borderWidth = 0
            retypeNewPasswordTextField.layer.borderWidth = 0
        }
    }
    
    func canChangePassword() -> Bool {
        (oldPasswordPassed && newPasswordPassed && passwordVirificationPassed) ? true : false
    }
    
    func updatePasswordButtonStatus() {
        if oldPasswordPassed && newPasswordPassed && passwordVirificationPassed {
            changePasswordButton.isEnabled = true
            changePasswordButton.backgroundColor = UIColor(named: "Webroot")
        } else {
            changePasswordButton.isEnabled = false
            changePasswordButton.backgroundColor = UIColor.gray
        }
    }
    
    @IBAction func signOutButtonPressed(_ sender: GeneralUIButton) {
        self.performSegue(withIdentifier: "signOutSegue", sender: nil)
    }
}
