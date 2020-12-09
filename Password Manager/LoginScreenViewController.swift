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
        print("press")
        
        if passwordEntryTextField.text != masterPassword {
            feedBackLabel.text = "Wrong Password, Try Agien"
        } else {
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
