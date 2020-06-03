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
    
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var emailTextView: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet weak var passWordTextView: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet weak var loginBtnOutlet: UIButton!
    
  
      
    //
    //    @IBOutlet weak var googleSignInBtn: GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Google Sign In /
     
        loginBtnOutlet.layer.cornerRadius=30
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
        //activityIndicator.hide()
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
            var loginPresenter : LoginPresenter = LoginPresenter(loginViewRef: self)
            loginPresenter.checkUser(email: emailTextView.text!, password: passWordTextView.text!)
            //  Login code
        }
        else{
            
            //show Alert Here .... empty fileds
            Alert.showSimpleAlert(title: "sorry", message: "Please Fill Required Fields", viewRef: self)
            
        }
    }
    
    
    
    @IBAction func resetPassword(_ sender: Any) {
        
        let resetPassPopup = (
            storyboard?.instantiateViewController(
                withIdentifier: "resetPopUpTV"))!
        present(resetPassPopup, animated: true, completion: nil)
    }
    
    @IBAction func goToSignupSB(_ sender: Any) {
        
        let signup = (
            storyboard?.instantiateViewController(
                withIdentifier: "signupSVC"))!
        
        present(signup, animated: true, completion: nil)
        
    }
    
    
    
}




extension LoginVC : ILoginVC {
   //var activityIndicator: UIActivityIndicatorView!
    func userValidation() {
        dismiss(animated: true, completion: nil)
        print("Loged Successfuly ... ")
        
        
        let employeeRequest = self.storyboard?.instantiateViewController(withIdentifier: "EmpRequestSVC") 
        navigationController?.pushViewController(employeeRequest!, animated: true)
        
    }
    
    func showIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
   //     activityIndicator.show()
        loginBtnOutlet.alpha = 0
//        activityIndicator.startAnimating()
    }
    
    func hideIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        //activityIndicator.hide()
        loginBtnOutlet.alpha = 1
//        activityIndicator.stopAnimating()
    }
    
    func errorMessage(msg: String) {
        Alert.showSimpleAlert(title: "sorry",message: msg, viewRef: self)
    }
    
    
}



