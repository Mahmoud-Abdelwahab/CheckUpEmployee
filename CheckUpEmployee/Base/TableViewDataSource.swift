//
//  TableViewDataSource.swift
//  CheckUpEmployee
//
//  Created by Hassan Khamis on 6/5/20.
//  Copyright © 2020 Mahmoud.kasper. All rights reserved.
//

import Foundation
import UIKit

class DataSource: NSObject,

UITableViewDataSource, UITableViewDelegate {
    var phoneList: [Phone]
    init(phoneList: [Phone]) {
        self.phoneList = phoneList
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phoneList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactTableViewCell
        
        cell.phoneNumberTxt.text = phoneList[indexPath.row].number!

        cell.phoneTypeImage.image = phoneList[indexPath.row].isLand == true ?  UIImage(named: "Office Phone_100px") : UIImage(named: "iPhone_100px")
        cell.callBtn.tag = indexPath.row
        cell.callBtn.addTarget(self, action: #selector(callNumber), for: .touchUpInside)
        // Configure the cell...

        return cell
    }
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        // Write action code for the trash
        let callAction = UIContextualAction(style: .normal, title:  "Call...", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            guard let number = URL(string: "tel://" + self.phoneList[indexPath.row].number!) else { return }
                    UIApplication.shared.open(number)
            success(true)
        })
        callAction.backgroundColor = .systemGreen

        


        return UISwipeActionsConfiguration(actions: [callAction])
    }
    @objc func callNumber(_ sender: UIButton) {
        guard let number = URL(string: "tel://" + self.phoneList[sender.tag].number!) else { return }
        UIApplication.shared.open(number)
    }
}
