//
//  AddAccountViewController.swift
//  Password Manager
//
//  Created by Álvaro Santillan on 12/10/20.
//  Copyright © 2020 Álvaro Santillan. All rights reserved.
//

import UIKit

// To-do disable auto segestions in input fields.
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
    
    func newAccountManager() {
        // Remove leading and trailing whitespaces.
        let accountText = accountNameTextField.text?.trimmingCharacters(in: .whitespaces)
        let usernameText = userNameTextField.text?.trimmingCharacters(in: .whitespaces)
        let passwordText = passwordTextField.text?.trimmingCharacters(in: .whitespaces)

        // Handle adding a new account.
        if inputValidator(input: accountText ?? "") != false && inputValidator(input: passwordText ?? "") != false && inputValidator(input: usernameText ?? "") != false {
            addAccountButton.isEnabled = true
            addAccountButton.backgroundColor = UIColor(named: "Webroot")
        } else {
            addAccountButton.isEnabled = false
            addAccountButton.backgroundColor = UIColor.gray
        }
    }
    
    // Make sure password contains letters or numbers.
    func inputValidator(input: String) -> Bool {
        let decimalRange = input.rangeOfCharacter(from: CharacterSet.decimalDigits)
        let letterRange = input.rangeOfCharacter(from: CharacterSet.letters)
        
        return (letterRange != nil || decimalRange != nil) ? true : false
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
        // Remove leading and trailing whitespaces:
        let accountText = accountNameTextField.text?.trimmingCharacters(in: .whitespaces)
        let usernameText = userNameTextField.text?.trimmingCharacters(in: .whitespaces)
        let passwordText = passwordTextField.text?.trimmingCharacters(in: .whitespaces)
        
        if accountText != nil {
            // Create and add a new cell.
            let newCellData = cellData(opened: false, title: accountText!, sectionData: [("Username: " + usernameText!), ("Password: " + passwordText!)])
            tableViewData.append(newCellData)
            
            // Reset the UI.
            accountNameTextField.text = nil
            userNameTextField.text = nil
            passwordTextField.text = nil
            addAccountButton.isEnabled = false
            addAccountButton.backgroundColor = UIColor.gray
        }
    }
}
