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
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var addAccountButton: GeneralUIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        accountNameTextField.delegate = self
//        passwordTextField.delegate = self
        addAccountButton.isEnabled = false
//        print(addAccountButton.backgroundColor)
        addAccountButton.backgroundColor = UIColor.gray
    }
    
    @IBAction func accountTextFieldChanged(_ sender: UITextField) {
        // Remove leading and trailing whitespaces:
        let accountText = accountNameTextField.text?.trimmingCharacters(in: .whitespaces)
        let passwordText = passwordTextField.text?.trimmingCharacters(in: .whitespaces)

        if inputValidator(input: accountText ?? "") != false && inputValidator(input: passwordText ?? "") != false {
            addAccountButton.isEnabled = true
            addAccountButton.backgroundColor = UIColor(named: "Webroot")
        } else {
            addAccountButton.isEnabled = false
            addAccountButton.backgroundColor = UIColor.gray
        }
    }
    
    @IBAction func passwordTextFieldChanged(_ sender: UITextField) {
        // Remove leading and trailing whitespaces:
        let accountText = accountNameTextField.text?.trimmingCharacters(in: .whitespaces)
        let passwordText = passwordTextField.text?.trimmingCharacters(in: .whitespaces)

        if inputValidator(input: accountText ?? "") != false && inputValidator(input: passwordText ?? "") != false {
            addAccountButton.isEnabled = true
            addAccountButton.backgroundColor = UIColor(named: "Webroot")
        } else {
            addAccountButton.isEnabled = false
            addAccountButton.backgroundColor = UIColor.gray
        }
    }
    
    @IBAction func addAccountButtonPressed(_ sender: GeneralUIButton) {
        var existingAccount = false
        // Remove leading and trailing whitespaces:
        let accountText = accountNameTextField.text?.trimmingCharacters(in: .whitespaces)
        let passwordText = passwordTextField.text?.trimmingCharacters(in: .whitespaces)
        
        if accountText != nil {
            for i in list {
                if accountText == i {
                    print(i, i.count)
                    list.remove(at: i.count-1)
                    list.insert(accountText ?? "O no bob", at: i.count-1)
                    existingAccount = true
                    passwordTextField.text = nil
                    accountNameTextField.text = nil
                    addAccountButton.isEnabled = false
                    addAccountButton.backgroundColor = UIColor.gray
                }
            }
            
            if existingAccount == false {
                list.append(accountText ?? "O no bob")
                passwordTextField.text = nil
                accountNameTextField.text = nil
                addAccountButton.isEnabled = false
                addAccountButton.backgroundColor = UIColor.gray
            }
        }
    }
    
    func inputValidator(input: String) -> Bool {
        let decimalCharacters = CharacterSet.decimalDigits
        let letterCharacters = CharacterSet.letters
        let decimalRange = input.rangeOfCharacter(from: decimalCharacters)
        let letterRange = input.rangeOfCharacter(from: letterCharacters)
        
        if letterRange != nil || decimalRange != nil {
            print("found")
            return true
        } else {
            print("not")
            return false
        }
    }
}


//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        print(textField.text)
//
//        let accountText = accountNameTextField.text?.trimmingCharacters(in: .whitespaces)
//        let passwordText = passwordTextField.text?.trimmingCharacters(in: .whitespaces)
//
//        if inputValidator(input: accountText ?? "") != false && inputValidator(input: passwordText ?? "") != false {
//            addAccountButton.isEnabled = true
//            addAccountButton.backgroundColor = UIColor(named: "Webroot")
//        } else {
//            addAccountButton.isEnabled = false
//            addAccountButton.backgroundColor = UIColor.gray
//        }
////        let newLength = count(textField.text.utf16) + count(string.utf16) - range.length
////        if(newLength <= 14){
////            self.label.text = "\(14 - newLength)"
//            return true
////        }else{
////            return false
////        }
//    }
