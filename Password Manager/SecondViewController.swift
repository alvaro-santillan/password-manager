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
        addAccountButton.isEnabled = false
//        print(addAccountButton.backgroundColor)
        addAccountButton.backgroundColor = UIColor.gray
        // Do any additional setup after loading the view.
    }
    
    @IBAction func accountTextFieldPressed(_ sender: UITextField) {
        let letters = NSCharacterSet.letters
        let sd = accountNameTextField.text?.rangeOfCharacter(from: letters)
        
        if passwordTextField.text != nil && accountNameTextField.text != nil {
            addAccountButton.isEnabled = true
            addAccountButton.backgroundColor = UIColor(named: "Webroot")
        } else {
            addAccountButton.isEnabled = false
            addAccountButton.backgroundColor = UIColor.gray
        }
    }
    
    @IBAction func passwordTextFieldPressed(_ sender: UITextField) {
        if passwordTextField.text != nil && accountNameTextField.text != nil {
            addAccountButton.isEnabled = true
            addAccountButton.backgroundColor = UIColor(named: "Webroot")
        } else {
            addAccountButton.isEnabled = false
            addAccountButton.backgroundColor = UIColor.gray
//            addAccountButton.backgroundColor = UIColor(named: "Webroot")
        }
    }
    
    @IBAction func addAccountButtonPressed(_ sender: GeneralUIButton) {
        var existingAccount = false
        if accountNameTextField.text != nil {
            for i in list {
                if accountNameTextField.text == i {
                    print(i, i.count)
                    list.remove(at: i.count)
                    list.insert(accountNameTextField.text ?? "O no bob", at: i.count)
                    existingAccount = true
                    passwordTextField.text = nil
                    accountNameTextField.text = nil
                    addAccountButton.isEnabled = false
                    addAccountButton.backgroundColor = UIColor.gray
                }
            }
            
            if existingAccount == false {
                list.append(accountNameTextField.text ?? "O no bob")
                passwordTextField.text = nil
                accountNameTextField.text = nil
                addAccountButton.isEnabled = false
                addAccountButton.backgroundColor = UIColor.gray
            }
        }
    }
    
}

