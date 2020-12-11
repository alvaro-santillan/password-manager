//
//  AddAccountViewController.swift
//  Password Manager
//
//  Created by Álvaro Santillan on 12/10/20.
//  Copyright © 2020 Álvaro Santillan. All rights reserved.
//

import UIKit

class AddAccountViewController: UIViewController {
    @IBOutlet weak var accountNameTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var addAccountButton: GeneralUIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAccountButton.isEnabled = false
        addAccountButton.backgroundColor = UIColor.gray
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
