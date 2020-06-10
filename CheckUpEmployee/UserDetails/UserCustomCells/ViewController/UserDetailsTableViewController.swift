//
//  UserDetailsTableViewController.swift
//  CheckUpEmployee
//
//  Created by Hassan Khamis on 6/5/20.
//  Copyright © 2020 Mahmoud.kasper. All rights reserved.
//

import UIKit
import MapKit
import SDWebImage

class UserDetailsTableViewController: UITableViewController {
    @IBOutlet weak var photoCell: UITableViewCell!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var buildingNoLbl: UILabel!
    @IBOutlet weak var floorNoLbl: UILabel!
    @IBOutlet weak var appartmentNoLbl: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBAction func startNavigationBtn(_ sender: UIButton) {
            let regionDistance : CLLocationDistance = 1000
        let coordinates =   CLLocationCoordinate2DMake(fullUser.address!.latitude!, fullUser.address!.longitude!)
            let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
            let options = [MKLaunchOptionsMapCenterKey : NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey : NSValue(mkCoordinateSpan: regionSpan.span)]
            let placeMark = MKPlacemark(coordinate: coordinates)
            let mapItem = MKMapItem(placemark: placeMark)
        mapItem.name = fullUser.fireBaseUser!.name
            
            mapItem.openInMaps(launchOptions: options)
        
    }
    
    @IBOutlet weak var contactTableView: ContactTableView!
    var dataSource : DataSource!
    var fullUser: FullUser!
    override func viewDidLoad() {
        super.viewDidLoad()
        photoCell.addGradientBackground(firstColor: #colorLiteral(red: 0.5490196078, green: 0.4156862745, blue: 0.6196078431, alpha: 1), secondColor: #colorLiteral(red: 0, green: 0.3098039216, blue: 0.5607843137, alpha: 1))
//        let gradient = CAGradientLayer()
//                var bounds = headerView.bounds
////                bounds.size.height += UIApplication.shared.statusBarFrame.size.height
//                gradient.frame = bounds
//        //        gradientLayer.colors = [#colorLiteral(red: 0, green: 0.5725490196, blue: 0.2705882353, alpha: 1).cgColor, UIColor(red: 131/255, green: 234/255, blue: 241/255, alpha: 1).cgColor]
//        //        gradient.colors = [UIColor(red: 131/255, green: 234/255, blue: 241/255, alpha: 1).cgColor, #colorLiteral(red: 0.3882352941, green: 0.6431372549, blue: 1, alpha: 1).cgColor]
//                gradient.colors = [#colorLiteral(red: 0.03529411765, green: 0.7411764706, blue: 0.9764705882, alpha: 1).cgColor, #colorLiteral(red: 0.03529411765, green: 0.7411764706, blue: 0.9764705882, alpha: 1).cgColor]
//        if let image = getImageFrom(gradientLayer: gradient) {
//            headerView.setBackgroundImage(image, for: UIBarMetrics.default)
//        }
        //        gradient.colors = [#colorLiteral(red: 0.2705882353, green: 0.3607843137, blue: 0.9921568627, alpha: 1).cgColor, #colorLiteral(red: 0.1607843137, green: 0.5921568627, blue: 0.9529411765, alpha: 1).cgColor]
        //        gradient.colors = [UIColor.init(red: 131, green: 234, blue: 241, alpha: 1), UIColor.init(red: 99, green: 164, blue: 255, alpha: 1)]
        //        gradient.colors = [UIColor.blue.cgColor, UIColor.systemTeal.cgColor]
//                gradient.startPoint = CGPoint(x: 0, y: 0)
//                gradient.endPoint = CGPoint(x: 1, y: 0)
        
//
//        var phone1 = Phone(number: "01121502499", isLand: false)
//        var phone2 = Phone(number: "03488888", isLand: true)
//        var address = Address(address1: "denokrat street - el Azarita,bab sharq, Alexandria", buildingNo: "2", floorNo: "5", apartmentNo: "30", longitude: 29.910315, latitude: 31.205498)
       // user = User(id: "5", name: "Hassan Khamis", email: "hassankhamis99@gmail.com", birthdate: "Feb 14, 1997", gender: "Male", phone: [phone1,phone2], insurance: "", address: address, imagePath: "https://image.shutterstock.com/image-photo/portrait-smiling-red-haired-millennial-260nw-1194497251.jpg")
       dataSource = DataSource(phoneList: fullUser.fireBaseUser!.phone!)
        contactTableView.dataSource = dataSource
        contactTableView.delegate = dataSource
        userImageView.layer.cornerRadius=userImageView.frame.width / 2
        userImageView.sd_setImage(with: URL(string: fullUser.fireBaseUser!.imagePath!), placeholderImage:UIImage(named: "placeholder.png"))
        userNameLbl.text = fullUser.fireBaseUser!.name!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let birthDate = dateFormatter.date(from: fullUser.fireBaseUser!.birthdate!)!
        let now = Date()
        let calendar = Calendar.current

        let ageComponents = calendar.dateComponents([.year], from: birthDate, to: now)
        let age = ageComponents.year!
        ageLbl.text = String(age) + " years"
        addressLbl.text = fullUser.address!.address1!
        buildingNoLbl.text = fullUser.address!.buildingNo!
        floorNoLbl.text = fullUser.address!.floorNo!
        appartmentNoLbl.text = fullUser.address!.apartmentNo!
        
        let annotation = MKPointAnnotation()
        annotation.title = fullUser.fireBaseUser?.name!
        //        annotation.coordinate = CLLocationCoordinate2D(latitude: (branchDescriptionView.address?.latitude)!, longitude: (branchDescriptionView.address?.longitude)!)
        annotation.coordinate = CLLocationCoordinate2D(latitude: fullUser.address!.latitude!, longitude: fullUser.address!.longitude!)
                mapView.addAnnotation(annotation)
        mapView.fitAll(in: [annotation], andShow: true)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0) {
            return 316
        }
        if(indexPath.row == 1) {
            if fullUser.fireBaseUser!.phone!.count == 1{
        return 105
        }
        else {
            return 150
        }
        }
        
           return UITableView.automaticDimension
        
    }
    
    
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        guard let number = URL(string: "tel://" + "4151231234") else { return }
//        UIApplication.shared.open(number)
//    }
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
