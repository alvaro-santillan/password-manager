//
//  extensions.swift
//  Password Manager
//
//  Created by Álvaro Santillan on 12/11/20.
//  Copyright © 2020 Álvaro Santillan. All rights reserved.
//

import UIKit

// Dismiss the keyboard
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
