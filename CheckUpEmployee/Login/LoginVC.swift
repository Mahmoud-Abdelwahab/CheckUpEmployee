//
//  ViewController.swift
//  CheckUpEmployee
//
//  Created by kasper on 6/1/20.
//  Copyright © 2020 Mahmoud.kasper. All rights reserved.
//

import UIKit
import TransitionButton
import SkyFloatingLabelTextField
import Firebase
import  SkyFloatingLabelTextField
class LoginVC: UITableViewController,UITextFieldDelegate, IView  {
    var isLogout :Bool = false
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var emailTextView: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet weak var passWordTextView: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet weak var loginBtnOutlet: UIButton!
    var loginPresenter : LoginPresenter!
    //
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        //        let employeeRequest = self.storyboard?.instantiateViewController(withIdentifier: "EmpRequestSVC") as! EmployeeRequestsVC
        //  employeeRequest.modalPresentationStyle = .fullScreen
        
        //        employeeRequest.fromLogout = {
        //            self.isLogout = true
        //
        //        }
        
        
        
    }
    
    //
    //    @IBOutlet weak var googleSignInBtn: GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // let btn :  UIBarButtonItem = UIBarButtonItem()
        //  self.navigationItem.setLeftBarButton(btn, animated: true)
        
        if Auth.auth().currentUser?.uid != nil && isLogout == false {
            let employeeRequestsVC = self.storyboard!.instantiateViewController(withIdentifier: "EmpRequestSVC") as! EmployeeRequestsVC
            
            navigationController?.pushViewController(employeeRequestsVC, animated: true)
        }
        
        /// Google Sign In //
        //self.modalPresentationStyle = .fullScreen
        //  self.present(self, animated: true, completion: nil)
        loginPresenter = LoginPresenter(loginViewRef: self)
        loginBtnOutlet.layer.cornerRadius=10
        loginBtnOutlet.layer.borderColor=UIColor.white.cgColor
        loginBtnOutlet.layer.borderWidth=2
        
        
        // to enable return key
        emailTextView.delegate=self
        passWordTextView.delegate=self
        //
        
        // to enable hide key board when touching any where
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        view.addGestureRecognizer(tap)
        activityIndicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        activityIndicator.isHidden = true
    }
    //  function to enable dimiss key board(Return key)
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
    // function to enable dimiss key board(touch any where )
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    
    @IBAction func loginBtn(_ sender: Any) {
        
        
        
        
        if (emailTextView.text?.isEmpty == false && passWordTextView.text?.isEmpty == false){
            
            loginPresenter.checkUser(email: emailTextView.text!, password: passWordTextView.text!)
            //  Login code
        }
        else{
            
            //show Alert Here .... empty fileds
            Alert.showSimpleAlert(title: "sorry", message: "Please Fill Required Fields", viewRef: self)
            
        }
    }
    
    
    
    //    @IBAction func resetPassword(_ sender: Any) {
    //
    //        let resetPassPopup = (
    //            storyboard?.instantiateViewController(
    //                withIdentifier: "resetPopUpTV"))!
    //        present(resetPassPopup, animated: true, completion: nil)
    //    }
    //
    //    @IBAction func goToSignupSB(_ sender: Any) {
    //
    //        let signup = (
    //            storyboard?.instantiateViewController(
    //                withIdentifier: "signupSVC"))!
    //
    //        present(signup, animated: true, completion: nil)
    //
    //    }
    
    
    
}




extension LoginVC : ILoginVC , LogoutDelegate {
    func logMeout() {
        isLogout = true
    }
    
    func onEmplopyeeExists() {
        let employeeRequestsVC = self.storyboard!.instantiateViewController(withIdentifier: "EmpRequestSVC") as! EmployeeRequestsVC
        //  employeeRequestsVC.modalPresentationStyle = .fullScreen
        self.present(employeeRequestsVC, animated: true, completion: nil)
    }
    
    //var activityIndicator: UIActivityIndicatorView!
    
    func userValidation() {
        // dismiss(animated: true, completion: nil)
        print("Loged Successfuly ... ")
        
        
        let employeeRequest = self.storyboard?.instantiateViewController(withIdentifier: "EmpRequestSVC") as! EmployeeRequestsVC
        navigationController?.pushViewController(employeeRequest, animated: true)
        
        //        let nav = UINavigationController.init(rootViewController:employeeRequest )
        //        employeeRequest.modalPresentationStyle = .fullScreen
        //        nav.present(employeeRequest, animated: true, completion: nil)
        //        employeeRequest!.modalPresentationStyle = .pageSheet
        //        self.present(employeeRequest!, animated: true, completion: nil)
        
    }
    
    func showIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        activityIndicator.isHidden = false
        loginBtnOutlet.alpha = 0
        activityIndicator.startAnimating()
    }
    
    func hideIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        activityIndicator.isHidden = true
        //activityIndicator.hide()
        loginBtnOutlet.alpha = 1
        activityIndicator.stopAnimating()
    }
    
    func errorMessage(msg: String) {
        Alert.showSimpleAlert(title: "sorry",message: msg, viewRef: self)
    }
    
    
}



