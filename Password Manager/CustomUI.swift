//
//  CustomUI.swift
//  Password Manager
//
//  Created by Álvaro Santillan on 12/8/20.
//  Copyright © 2020 Álvaro Santillan. All rights reserved.
//

import UIKit

class GeneralUIButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 5
        self.layer.cornerRadius = 6
        self.imageView?.contentMode = .scaleAspectFit
    }
}
