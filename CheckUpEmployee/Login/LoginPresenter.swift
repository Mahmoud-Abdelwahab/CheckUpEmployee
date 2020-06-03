//
//  LoginPresenter.swift
//  CheckUpEmployee
//
//  Created by kasper on 6/1/20.
//  Copyright © 2020 Mahmoud.kasper. All rights reserved.
//
	
import Foundation
class LoginPresenter: ILoginPresenter {
    
    var loginViewRef : ILoginVC!
    init(loginViewRef : ILoginVC) {
        self.loginViewRef = loginViewRef
    }
    func checkUser(email: String,password: String){
        loginViewRef.showIndicator()

        var loginModel = LoginModel(loginPresenterRef: self)
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

