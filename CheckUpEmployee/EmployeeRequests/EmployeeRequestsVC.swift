//
//  EmployeeRequestsVC.swift
//  CheckUpEmployee
//
//  Created by kasper on 6/1/20.
//  Copyright © 2020 Mahmoud.kasper. All rights reserved.
//

import UIKit
import SDWebImage
class EmployeeRequestsVC: UITableViewController {
    var users : [User] = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user : User = User(id: "sfsdfs", name: "Mahmoud", email: "mahmoudabdelwahab199390@gmail.com", birthdate: "25-11-1993", gender: "male", phone: [Phone(number: "01149060094", isLand: false)], insurance: "Yes", address: Address(address1: "Qenaa", buildingNo: "1", floorNo: "1", apartmentNo: "2", longitude: 90.0, latitude: 120.45), imagePath:"https://firebasestorage.googleapis.com/v0/b/checkup-23ffe.appspot.com/o/users.png?alt=media&token=8fba9f3d-0739-4b7f-afab-8ae7b6e1c442")
            
            
            
        tableView.register(UINib(nibName: "UserCustomTableViewCell", bundle: nil), forCellReuseIdentifier: "userCustomCell")
        
        users.append(user)
        users.append(user)
        users.append(user)
        users.append(user)

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCustomCell", for: indexPath) as! UserCustomTableViewCell
        
        cell.userName.text = users[indexPath.row].name
        if let imgPath = users[indexPath.row].imagePath {
                  cell.userImg.sd_setImage(with: URL(string: users[indexPath.row].imagePath!), placeholderImage:UIImage(named: "placeholder.png"))
             }
            
             if let location = users[indexPath.row].address {
                  //  cell.userAddress.text = users[indexPath.row].address
                
                        }
        
        
       
        
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let userDataSB = storyboard?.instantiateViewController(withIdentifier: "userDataSB") as? UserDataTableViewController else { return }
        
      //  userDataSB.patientData = users[indexPath.row]
        navigationController?.pushViewController(userDataSB, animated: true)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}