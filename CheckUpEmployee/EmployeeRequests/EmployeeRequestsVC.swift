//
//  EmployeeRequestsVC.swift
//  CheckUpEmployee
//
//  Created by kasper on 6/1/20.
//  Copyright © 2020 Mahmoud.kasper. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase
class EmployeeRequestsVC: UITableViewController {
    var users  = [User]()
    var fromLogout:(()->())?
    var employeeRequestPresenter:EmployeeRequestsPresenter!
    //var logoutDelegate:LogoutDelegate!
    @IBAction func logoutBtn(_ sender: Any){
        print("Logout ..")
        guard  let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "loginSVC") as? LoginVC else {return}
               loginVC.logMeout()
         do{
                try Auth.auth().signOut()
               
            }
            catch{
        
            }

        navigationController?.popViewController(animated: true)
    }
    

    override func viewWillAppear(_ animated: Bool) {
           navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
         employeeRequestPresenter = EmployeeRequestsPresenter (empRequestViewRef: self)
        employeeRequestPresenter.getUserRequests()
        
        
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

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 90
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCustomCell", for: indexPath) as! UserCustomTableViewCell
        
        cell.userName.text = users[indexPath.row].name
//        if let imgPath = users[indexPath.row].imagePath {
//                  cell.userImg.sd_setImage(with: URL(string: users[indexPath.row].imagePath!), placeholderImage:UIImage(named: "placeholder.png"))
//             }
            
             if let location = users[indexPath.row].address {
                  //  cell.userAddress.text = users[indexPath.row].address
                
                        }
        
        //*************///
        
       // will be executed when user tap on the button
        // notice the capture block has [unowned self]
        // the 'self' is the viewcontroller
        cell.getDirectionClosure = { [unowned self] in
         
            let alert = UIAlertController(title: "Subscribed!", message: "Subscribed to Mahmoud Cell number : \(indexPath.row)", preferredStyle: .alert)
          let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
          alert.addAction(okAction)
                
          self.present(alert, animated: true, completion: nil)
            //Apple Maps

            if (UIApplication.shared.canOpenURL(NSURL(string:"http://maps.apple.com")! as URL)) {
                UIApplication.shared.openURL(NSURL(string:
                "http://maps.apple.com/?daddr=San+Francisco,+CA&saddr=cupertino")as! URL)
              NSLog("Can't use Apple Maps");
            }
            
            
            
        }
        
        
        cell.calMeClouser = { [unowned self] in
         
            print("Calling .........")
           guard let number = URL(string: "tel://" + "4151231234") else { return }
            UIApplication.shared.open(number)
            //makePhoneCall(phoneNumber: users[2].phon[0])
        }
       
        
        // Configure the cell...

        return cell
    }
    
    func makePhoneCall(phoneNumber: String) {

        if let phoneURL = NSURL(string: ("tel://" + phoneNumber)) {

            let alert = UIAlertController(title: ("Call " + phoneNumber + "?"), message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Call", style: .default, handler: { (action) in
                UIApplication.shared.open(phoneURL as URL, options: [:], completionHandler: nil)
            }))

            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        guard let userDataSB = storyboard?.instantiateViewController(withIdentifier: "userDataSB") as? UserDataTableViewController else { return }
        
      //  userDataSB.patientData = users[indexPath.row]
//        navigationController?.pushViewController(userDataSB, animated: true)
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

extension EmployeeRequestsVC:IEmployeeRequestsView
{
    func OnReceiveUserRequests(Requests: [User]) {
      users = Requests
        tableView.reloadData()
    }
    
    func OnFail(message: String) {
      
    }
    
 
}
