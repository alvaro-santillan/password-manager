//
//  AccountViewController.swift
//  Password Manager
//
//  Created by Álvaro Santillan on 12/9/20.
//  Copyright © 2020 Álvaro Santillan. All rights reserved.
//

import UIKit

struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}

// To-do securly store the table view data.
var tableViewData = [cellData(opened: false, title: "Amazon", sectionData: ["Username: timApple@icload.com", "Password: aAppleADay"]),
                    cellData(opened: false, title: "Webroot", sectionData: ["Username: joseph@webroot.com", "Password: password"]),
                    cellData(opened: false, title: "OpenText", sectionData: ["Username: david@opentext.com", "Password: dSdsjkfDHS1334!"]),
                    cellData(opened: false, title: "Carbonite", sectionData: ["Username: al@carbonite.com", "Password: AlIsTheBestGuy100%"])]

class AccountViewController: UITableViewController {
    @IBOutlet weak var newTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        tableViewData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewData[section].opened == true ? tableViewData[section].sectionData.count + 1 : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].title
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[indexPath.row - 1]
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if tableViewData[indexPath.section].opened == true {
                tableViewData[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            } else {
                tableViewData[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            tableViewData.remove(at: indexPath[0])
            newTableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        newTableView.reloadData()
    }
}
