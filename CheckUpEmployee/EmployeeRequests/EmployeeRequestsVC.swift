//
//  EmployeeRequestsVC.swift
//  CheckUpEmployee
//
//  Created by kasper on 6/1/20.
//  Copyright © 2020 Mahmoud.kasper. All rights reserved.
//

import Foundation
import UIKit

import SDWebImage

import Firebase

import MapKit

class EmployeeRequestsVC: UITableViewController {
 
    
    @IBAction func refreshBtn(_ sender: Any) {
    getData()
    }
    var userRequestsList: [FullUser]?

    var fromLogout:(()->())?

    var employeeRequestPresenter:EmployeeRequestsPresenter!
    var errorMessage: String!
    //var logoutDelegate:LogoutDelegate!
    var isWaitingData = true
//    @IBOutlet weak var activityIndicstor: UIActivityIndicatorView!
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

//        activityIndicstor.isHidden = false
//   activityIndicstor.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
//        activityIndicstor.startAnimating()
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        getData()
        

    }
    func getData() {
        

        employeeRequestPresenter.getUserRequests()
    }
    override func viewDidLoad() {

        super.viewDidLoad()

       // tableView.allowsSelection = true

        userRequestsList = [FullUser]()

       employeeRequestPresenter = EmployeeRequestsPresenter (empRequestViewRef: self)

        

        

        // let user : User = User(id: "sfsdfs", name: "Mahmoud", email: "mahmoudabdelwahab199390@gmail.com", birthdate: "25-11-1993", gender: "male", phone: [Phone(number: "01149060094", isLand: false)], insurance: "Yes", address: Address(address1: "Qenaa", buildingNo: "1", floorNo: "1", apartmentNo: "2", longitude: 90.0, latitude: 120.45), imagePath:"https://firebasestorage.googleapis.com/v0/b/checkup-23ffe.appspot.com/o/users.png?alt=media&token=8fba9f3d-0739-4b7f-afab-8ae7b6e1c442")

        


        tableView.register(UINib(nibName: "UserCustomTableViewCell", bundle: nil), forCellReuseIdentifier: "userCustomCell")


    }

    

    // MARK: - Table view data source

    

    override func numberOfSections(in tableView: UITableView) -> Int {

        // #warning Incomplete implementation, return the number of sections

//        return 1
        var numOfSections: Int = 0
                if(isWaitingData){
        //            let activityView = UIActivityIndicatorView(style: .whiteLarge)
        //            activityView.center = self.view.center
        //            activityView.startAnimating()
        //
        //            self.view.addSubview(activityView)
        //            var activityView = UIActivityIndicatorView(style: .whiteLarge)
        //            activityView.center = self.view.center
        //            tableView.addSubview(activityView)
        //            activityView.startAnimating()
        //            numOfSections = 0
                    numOfSections = 0
        //            tableView.separatorStyle  = .none
                    tableView.showActivityIndicator()
                }
                else{
                        if userRequestsList!.count > 0
                        {
        //                    tableView.separatorStyle = .singleLine
                            numOfSections = 1
                            tableView.backgroundView = nil
                        }
                        else
                        {
                            numOfSections = 0
                            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
                            noDataLabel.text          = errorMessage.localized
                //            noDataLabel.textColor     = UIColor.black
                            noDataLabel.textAlignment = .center
                            tableView.backgroundView  = noDataLabel
                            
                        }
                }
                        return numOfSections
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 95

    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        // #warning Incomplete implementation, return the number of rows
        if userRequestsList!.count > 0{
//        activityIndicstor.isHidden = true
//            activityIndicstor.stopAnimating()
        }

        return userRequestsList?.count ?? 0
        
        

    }

    

    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "userCustomCell", for: indexPath) as! UserCustomTableViewCell

        

     cell.userName.text = userRequestsList?[indexPath.row].fireBaseUser?.name ?? "No Name"

        cell.generatedCodeText.text = userRequestsList?[indexPath.row].generatedCode ?? "-----"


            let dateTime =  "\(userRequestsList?[indexPath.row].dateForTakingSample! ?? "") \(userRequestsList?[indexPath.row].timeForTakingSample! ?? "")"

    

         cell.dateTimeText.text = dateTime

        if let imgPath = userRequestsList?[indexPath.row].fireBaseUser!.imagePath {

            cell.userImg.sd_setImage(with: URL(string: imgPath), placeholderImage:UIImage(named: "placeholder.png"))

        }

        

        if userRequestsList![indexPath.row].address != nil {

            //  cell.userAddress.text = users[indexPath.row].address

            

        }

    
        // will be executed when user tap on the button

        // notice the capture block has [unowned self]

        // the 'self' is the viewcontroller

        cell.getDirectionClosure = { [unowned self] in

  
            let regionDistance : CLLocationDistance = 1000

            let coordinates = CLLocationCoordinate2DMake((self.userRequestsList?[indexPath.row].address!.latitude!)!, (self.userRequestsList?[indexPath.row].address!.longitude)!)

                       let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)

                       let options = [MKLaunchOptionsMapCenterKey : NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey : NSValue(mkCoordinateSpan: regionSpan.span)]

                       let placeMark = MKPlacemark(coordinate: coordinates)

                       let mapItem = MKMapItem(placemark: placeMark)

                           mapItem.name = self.userRequestsList?[indexPath.row].fireBaseUser!.name

                       

                       mapItem.openInMaps(launchOptions: options)


            

        }

        

        

        //        cell.calMeClouser = { [unowned self] in

        //

        //            print("Calling .........")

        //           guard let number = URL(string: "tel://" + "4151231234") else { return }

        //            UIApplication.shared.open(number)

        //            //makePhoneCall(phoneNumber: users[2].phon[0])

        //        }

        

        

        // Configure the cell...

        

        return cell

    }

    
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

         

              let userDataSB = storyboard?.instantiateViewController(withIdentifier: "userDetailsViewControllerSB") as! UserDetailsViewController
        userDataSB.ibaseRef = self
             userDataSB.fullUser = userRequestsList![indexPath.row]
             navigationController?.pushViewController(userDataSB, animated: true)

      

      
 //        var phone1 = Phone(number: "01121502499", isLand: false)

 //        var phone2 = Phone(number: "03488888", isLand: true)

 //        var address = Address(address1: "denokrat street - el Azarita,bab sharq, Alexandria", buildingNo: "2", floorNo: "5", apartmentNo: "30", longitude: 29.910315, latitude: 31.205498)

 //        user = User(id: "5", name: "Hassan Khamis", email: "hassankhamis99@gmail.com", birthdate: "Feb 14, 1997", gender: "Male", phone: [phone1,phone2], insurance: "", address: address, imagePath: "https://image.shutterstock.com/image-photo/portrait-smiling-red-haired-millennial-260nw-1194497251.jpg")



     //    guard let userDataSB = storyboard?.instantiateViewController(withIdentifier: "userDetailsViewControllerSB") as? UserDetailsViewController else { return }

        // userDataSB.user = self.user

        // userDataSB.patientData = userRequestsList[indexPath.row]


     }
    
    func hideIndicator() {
        isWaitingData = false
//        self.activityIndicstor.isHidden = true
//                   activityIndicstor.stopAnimating()

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

    func OnReceiveUserRequests(Requests: [FullUser]) {
        isWaitingData = false
        userRequestsList = Requests
        if userRequestsList!.isEmpty {
            errorMessage = "There is no data to show"
        }

        tableView.reloadData()

    }

    

    func showIndicator() {
isWaitingData = true
//        tableView.reloadData()

    }

    

    

    

    func errorMessage(msg: String) {

        errorMessage = msg

    }

    

   

    

    func OnFail(message: String) {
errorMessage = message

    }

    

 

}

