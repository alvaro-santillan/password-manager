//
//  AboutMeViewController.swift
//  Password Manager
//
//  Created by Álvaro Santillan on 12/10/20.
//  Copyright © 2020 Álvaro Santillan. All rights reserved.
//

import UIKit

class AboutMeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Determins what URL to use.
    func urlSelector(webURL: String, appURL: String) {
        var selectedURL = String()
        UIApplication.shared.canOpenURL(URL(string: appURL)! as URL) ? (selectedURL = appURL) : (selectedURL = webURL)
        UIApplication.shared.open(URL(string: selectedURL)! as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func linkedInButtonTapped(_ sender: UIButton) {
        var webURL = "https://www.linkedin.com/in/álvarosantillan"
        webURL = webURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!

        var appURL = "linkedin://in/álvarosantillan"
        appURL = appURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        
        urlSelector(webURL: webURL, appURL: appURL)
    }
    
    @IBAction func personalWebisteButtonTapped(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "http://alvarosantillan.com/")! as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func githubButtonTapped(_ sender: UIButton) {
        var webURL = "https://github.com/alvaro-santillan"
        webURL = webURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        UIApplication.shared.open(URL(string: webURL)! as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func rateButtonTapped(_ sender: UIButton) {
        var webURL = "https://www.linkedin.com/in/álvarosantillan"
        webURL = webURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!

        let appID = "1522789474"
        var appURL = "http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=\(appID)&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"
        appURL = appURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        
        urlSelector(webURL: webURL, appURL: appURL)
    }
}
