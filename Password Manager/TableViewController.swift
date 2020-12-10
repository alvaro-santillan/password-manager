//
//  TableViewController.swift
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

//var masterPassword = "password"
var tableViewData = [cellData(opened: false, title: "Amazon", sectionData: ["Username: timApple@icload.com", "Password: aAppleADay"]),
                 cellData(opened: false, title: "B", sectionData: ["A", "B"]),
                 cellData(opened: false, title: "C", sectionData: ["A", "B"]),
                 cellData(opened: false, title: "D", sectionData: ["A", "B"])]

class TableViewController: UITableViewController {
    @IBOutlet weak var newTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        tableViewData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true {
            return tableViewData[section].sectionData.count + 1
        } else {
            return 1
        }
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
//            print(indexPath[0])
            tableViewData.remove(at: indexPath[0])
            newTableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        newTableView.reloadData()
    }
}
