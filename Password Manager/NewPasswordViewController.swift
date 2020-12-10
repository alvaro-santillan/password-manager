//
//  NewPasswordViewController.swift
//  Password Manager
//
//  Created by Álvaro Santillan on 12/10/20.
//  Copyright © 2020 Álvaro Santillan. All rights reserved.
//

import UIKit

class NewPasswordViewController: UIViewController {
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var retypeNewPasswordTextField: UITextField!
    @IBOutlet weak var passwordFeedbackLabel: UILabel!
    @IBOutlet weak var encriptButton: GeneralUIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    var newPasswordPassed: Bool = false
    var passwordVirificationPassed: Bool = false
    
    @IBAction func newPasswordTextFieldPressed(_ sender: UITextField) {
        // Remove leading and trailing whitespaces:
        // To-do: Should probilby red if spaces detected
        let newPasswordText = newPasswordTextField.text?.trimmingCharacters(in: .whitespaces)
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
        retypeNewPasswordTextFieldPressed(retypeNewPasswordTextField)
        updateEncriptButtonStatus()
    }

    @IBAction func retypeNewPasswordTextFieldPressed(_ sender: UITextField) {
        // Remove leading and trailing whitespaces:
        // To-do: Should probilby red if spaces detected
        let newPasswordText = newPasswordTextField.text?.trimmingCharacters(in: .whitespaces)
        let retypeNewPasswordText = retypeNewPasswordTextField.text?.trimmingCharacters(in: .whitespaces)

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
//        newPasswordTextFieldPressed(newPasswordTextField)
        updateEncriptButtonStatus()
    }
    
    @IBAction func encriptButtonPressed(_ sender: GeneralUIButton) {
        if canChangePassword() == true {
            let newPassword = newPasswordTextField.text?.trimmingCharacters(in: .whitespaces)
            KeychainWrapper.standard.set(newPassword!, forKey: "Password")
//            masterPassword = newPassword!
            encriptButton.isEnabled = false
            encriptButton.backgroundColor = UIColor.gray
//            oldPasswordTextField.text = nil
            newPasswordTextField.text = nil
            retypeNewPasswordTextField.text = nil
//            oldPasswordTextField.layer.borderWidth = 0
            newPasswordTextField.layer.borderWidth = 0
            retypeNewPasswordTextField.layer.borderWidth = 0
            self.performSegue(withIdentifier: "firstPasswordSetSegue", sender: nil)
        }
    }
    
    func updateEncriptButtonStatus() {
        if newPasswordPassed && passwordVirificationPassed {
            encriptButton.isEnabled = true
            encriptButton.backgroundColor = UIColor(named: "Webroot")
        } else {
            encriptButton.isEnabled = false
            encriptButton.backgroundColor = UIColor.gray
        }
    }
    
    func canChangePassword() -> Bool {
        if newPasswordPassed && passwordVirificationPassed {
            return true
        } else {
            return false
        }
    }
}
