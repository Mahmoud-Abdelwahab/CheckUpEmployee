//
//  LoginPresenter.swift
//  CheckUpEmployee
//
//  Created by kasper on 6/1/20.
//  Copyright © 2020 Mahmoud.kasper. All rights reserved.
//
	
import Foundation
class LoginPresenter: ILoginPresenter {
    func isEmployeeExists() {
    }
    
    var loginModel : LoginModel!
    var loginViewRef : ILoginVC!
     init(loginViewRef : ILoginVC) {
         loginModel = LoginModel(loginPresenterRef: self)
         self.loginViewRef = loginViewRef
     }
    
    func isEmployee() {
        loginModel.isEmployeeExists()
    }
    
   func onEmplopyeeExistsModel() {
    loginViewRef.onEmplopyeeExists()
    }
    
    
 
    func checkUser(email: String,password: String){
        loginViewRef.showIndicator()

        loginModel.checkUser(email: email, password: password)
//        loginModel.
    }
    func onSuccess(){
        loginViewRef.userValidation()
        loginViewRef.hideIndicator()
    }
    func onFail(message: String){
        loginViewRef.errorMessage(msg: message)
        loginViewRef.hideIndicator()
    }
}

