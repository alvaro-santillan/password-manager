//
//  SecondViewController.swift
//  Password Manager
//
//  Created by Álvaro Santillan on 12/8/20.
//  Copyright © 2020 Álvaro Santillan. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var accountNameTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var addAccountButton: GeneralUIButton!
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var retypeNewPasswordTextField: UITextField!
    @IBOutlet weak var passwordFeedbackLabel: UILabel!
    @IBOutlet weak var encriptButton: GeneralUIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAccountButton.isEnabled = false
        addAccountButton.backgroundColor = UIColor.gray
        encriptButton.isEnabled = false
        encriptButton.backgroundColor = UIColor.gray
    }
    
    @IBAction func accountTextFieldChanged(_ sender: UITextField) {
        newAccountManager()
    }
    
    @IBAction func usernameTextFieldChanged(_ sender: UITextField) {
        newAccountManager()
    }
    
    @IBAction func passwordTextFieldChanged(_ sender: UITextField) {
        newAccountManager()
    }
    
    
    @IBAction func addAccountButtonPressed(_ sender: GeneralUIButton) {
        var existingAccount = false
        // Remove leading and trailing whitespaces:
        let accountText = accountNameTextField.text?.trimmingCharacters(in: .whitespaces)
        let usernameText = userNameTextField.text?.trimmingCharacters(in: .whitespaces)
        let passwordText = passwordTextField.text?.trimmingCharacters(in: .whitespaces)
        
        if accountText != nil {
//            for i in tableViewData {
//                if ("Username: " + accountText!) == i.sectionData[0] {
////                    print(i, i.count)
//                    list.remove(at: i.count-1)
//                    list.insert(accountText ?? "O no bob", at: i.count-1)
//                    existingAccount = true
//                    passwordTextField.text = nil
//                    accountNameTextField.text = nil
//                    addAccountButton.isEnabled = false
//                    addAccountButton.backgroundColor = UIColor.gray
//                }
//            }
            
            if existingAccount == false {
                let tempCellData = cellData(opened: false, title: accountText ?? "O no bob", sectionData: [("Username: " + usernameText!), ("Password: " + passwordText!)])
                tableViewData.append(tempCellData)
                accountNameTextField.text = nil
                userNameTextField.text = nil
                passwordTextField.text = nil
                addAccountButton.isEnabled = false
                addAccountButton.backgroundColor = UIColor.gray
            }
        }
    }
    
    var oldPasswordPassed: Bool = false
    var newPasswordPassed: Bool = false
    var passwordVirificationPassed: Bool = false
    
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
        updateEncriptButtonStatus()
    }

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
            oldPasswordTextField.text = nil
            newPasswordTextField.text = nil
            retypeNewPasswordTextField.text = nil
            oldPasswordTextField.layer.borderWidth = 0
            newPasswordTextField.layer.borderWidth = 0
            retypeNewPasswordTextField.layer.borderWidth = 0
        }
    }
    
    func newAccountManager() {
        // Remove leading and trailing whitespaces:
        let accountText = accountNameTextField.text?.trimmingCharacters(in: .whitespaces)
        let usernameText = userNameTextField.text?.trimmingCharacters(in: .whitespaces)
        let passwordText = passwordTextField.text?.trimmingCharacters(in: .whitespaces)

        if inputValidator(input: accountText ?? "") != false && inputValidator(input: passwordText ?? "") != false && inputValidator(input: usernameText ?? "") != false {
            addAccountButton.isEnabled = true
            addAccountButton.backgroundColor = UIColor(named: "Webroot")
        } else {
            addAccountButton.isEnabled = false
            addAccountButton.backgroundColor = UIColor.gray
        }
    }
    
    func canChangePassword() -> Bool {
        if oldPasswordPassed && newPasswordPassed && passwordVirificationPassed {
            return true
        } else {
            return false
        }
    }
    
    func updateEncriptButtonStatus() {
        if oldPasswordPassed && newPasswordPassed && passwordVirificationPassed {
            encriptButton.isEnabled = true
            encriptButton.backgroundColor = UIColor(named: "Webroot")
        } else {
            encriptButton.isEnabled = false
            encriptButton.backgroundColor = UIColor.gray
        }
    }
    
    @IBAction func signOutButtonPressed(_ sender: GeneralUIButton) {
        self.performSegue(withIdentifier: "signOutSegue", sender: nil)
    }
    
    func inputValidator(input: String) -> Bool {
        let decimalCharacters = CharacterSet.decimalDigits
        let letterCharacters = CharacterSet.letters
        let decimalRange = input.rangeOfCharacter(from: decimalCharacters)
        let letterRange = input.rangeOfCharacter(from: letterCharacters)
        
        if letterRange != nil || decimalRange != nil {
//            print("found")
            return true
        } else {
//            print("not")
            return false
        }
    }
}
