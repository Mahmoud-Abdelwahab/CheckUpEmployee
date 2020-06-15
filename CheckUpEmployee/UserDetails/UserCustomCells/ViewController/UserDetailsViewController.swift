//
//  UserDetailsViewController.swift
//  CheckUpEmployee
//
//  Created by Hassan Khamis on 6/5/20.
//  Copyright © 2020 Mahmoud.kasper. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController,IViewAdvancedAlert{
    var fullUser: FullUser!
    var ibaseRef : IBase!
    
    var userRequestsSB : EmployeeRequestsVC!
                    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        userRequestsSB = storyboard?.instantiateViewController(withIdentifier: "EmpRequestSVC") as! EmployeeRequestsVC
       
    
           activityIndicatore.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
    self.activityIndicatore.isHidden = true
         activityIndicatore.stopAnimating()
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var activityIndicatore: UIActivityIndicatorView!
    
    
    
    @IBAction func takeSampleBtn(_ sender: Any) {
        Alert.showAdvancedAlert(title: "TakingSample".localized, message:"SAMPLE_CONFIRMATION".localized , viewAdvancedAlertRef: self)
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)

        if parent == nil {
            debugPrint("Back Button pressed.")
           // ibaseRef.hideIndicator()
            ibaseRef.hideIndicator()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if #available(iOS 13.0, *) {
            let destinationVC = segue.destination as! UserDetailsTableViewController
            destinationVC.fullUser = fullUser

        } else {
            // Fallback on earlier versions
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
 

extension UserDetailsViewController : IUserDetailsView,IBase ,IView,IOkAlert
{
    /// on press on  confirming that sample was taken
    func onOkClicked() {
        navigationController?.popViewController(animated: true)
//                    navigationController?.pushViewController(userRequestsSB, animated: true)

    }
    

func showIndicator() {
    
}
  
  func hideIndicator() {
     
  }
  
  func errorMessage(msg: String) {
  
  }

   
    
    /// on reciver pdate confirmation
    func getResult() {
        
        activityIndicatore.stopAnimating()
        self.activityIndicatore.isHidden = true
        Alert.simpleOkAlert(title: "UPDATED_SUCCESSFULLY_TITLE".localized, message: "UPDATED_SUCCESSFULLY_MSG".localized, viewRef: self)
    
      
    }
    
    func OnFail(message: String) {
      self.activityIndicatore.isHidden = true
        activityIndicatore.stopAnimating()
//      Alert.showSimpleAlert(title:"UPDATED_FAILED_TITLE".localized , message: "UPDATED_FAILED_MSG".localized, viewRef: self)
         Alert.showSimpleAlert(title:"UPDATED_FAILED_TITLE".localized , message: "UPDATED_FAILED_MSG".localized, viewRef: self)
    }
    
    
    //// alert functons
    func pressOk() {
       self.activityIndicatore.isHidden = false
        activityIndicatore.startAnimating()
          let userDetailsPresenter = UserDetailsPresenter( userDetailsViewRef: self)
        userDetailsPresenter.updateTestStatus(testId: fullUser.TestId!, userId: fullUser.UserId!)
    }
    
    func pressCancel() {
        self.activityIndicatore.isHidden = true
        activityIndicatore.stopAnimating()
    }
}

