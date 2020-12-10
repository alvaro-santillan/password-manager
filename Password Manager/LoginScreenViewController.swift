//
//  LoginScreenViewController.swift
//  Password Manager
//
//  Created by Álvaro Santillan on 12/8/20.
//  Copyright © 2020 Álvaro Santillan. All rights reserved.
//

import UIKit

class LoginScreenViewController: UIViewController {
    @IBOutlet weak var unlockButton: UIButton!
    @IBOutlet weak var passwordEntryTextField: UITextField!
    @IBOutlet weak var feedBackLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func unlockButtonPressed(_ sender: Any) {
        print(KeychainWrapper.standard.string(forKey: "Password"))
        
        if KeychainWrapper.standard.string(forKey: "Password") == nil {
            self.performSegue(withIdentifier: "unlockSegue", sender: nil)
        } else if passwordEntryTextField.text != KeychainWrapper.standard.string(forKey: "Password") {
            feedBackLabel.text = "Wrong Password, Try Agien"
            passwordEntryTextField.text = nil
        } else {
//            masterPassword = KeychainWrapper.standard.string(forKey: "Password") ?? ""
            self.performSegue(withIdentifier: "unlockSegue", sender: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
