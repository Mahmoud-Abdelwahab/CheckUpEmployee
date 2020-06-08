//
//  LoginModel.swift
//  CheckUpEmployee
//
//  Created by kasper on 6/1/20.
//  Copyright © 2020 Mahmoud.kasper. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
class LoginModel: ILoginModel {
    func isEmployeeModel() {
       
    }
    
  
    
 var db: Firestore!
    var loginPresenterRef : ILoginPresenter
    init(loginPresenterRef : ILoginPresenter) {
        self.loginPresenterRef = loginPresenterRef
        // [START setup]
               let settings = FirestoreSettings()

               Firestore.firestore().settings = settings
               // [END setup]
               db = Firestore.firestore()
    }
    
    
    var myClosureEmpIsFound : (()->())?
    
    func isEmployeeExists( ){
        
  
      
        
        
        
        if(Auth.auth().currentUser?.uid != nil )
        {
            
            db.collection("users").document(Auth.auth().currentUser!.uid).getDocument {
                (document  ,error) in
                
                guard let id = document?.data()?["id"] as? String?
                    else {
                        self.loginPresenterRef.onFail(message: "Sorry you have no access please login ... ")
                        return
                }
                
                self.loginPresenterRef.onEmplopyeeExistsModel()
                
            }
            
            
            
            
        }else{
            print(" please login .... ")
            loginPresenterRef.onFail(message: " please login first ") // login
        }
        
    }
     
    
    
    
    
    
    func  isEmployeeFound()  {
       
        
        guard let userId = Auth.auth().currentUser?.uid else {
              print("loge in   user id  is empty  .... ")
           return
        }
      
        
        db.collection("users").document(userId).getDocument {
                (document  ,error) in
                   
                 let type = document?.data()?["type"] as! Int
            
            if  type == 2 {
                  
                    self.myClosureEmpIsFound?()
                    
                }
            else{
                do{
                    try Auth.auth().signOut()
                    
                }
                catch{
                    
                }
                self.loginPresenterRef.onFail(message: "This account is not exists ")
            }
    
                   }
               
        
  
    
    }
    
    
    func checkUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if authResult != nil {
                //                authResult?.user.uid
              //  if self.isEmployeeFound() == true {
                self.isEmployeeFound()
                self.myClosureEmpIsFound = { [unowned self] in
                
                         self.loginPresenterRef.onSuccess()
                   
                     }
              
             //   }
            }
            else {
                var message: String!
                switch error!.localizedDescription {
                case "There is no user record corresponding to this identifier. The user may have been deleted.":
                    message = error!.localizedDescription
                    break
                    case "The email address is badly formatted.":
                                        message = error!.localizedDescription
                                        break
                    case "The password is invalid or the user does not have a password.":
                                        message = error!.localizedDescription
                                        break
                default:
                    message = "An error occured please try again later"
                }
                self.loginPresenterRef.onFail(message: message)
            }
        }
    }
}
