//
//  UserDetailsPresenter.swift
//  CheckUpEmployee
//
//  Created by kasper on 6/3/20.
//  Copyright © 2020 Mahmoud.kasper. All rights reserved.
//

import Foundation
class UserDetailsPresenter: IUserDetailsPresenter ,ICheckConnection {
    var testID :Int64?
    var userId: String!
    func onSucessfullyConnected() {
        var userDetailsModel = UserDetailsModel(userDetailsPresenterRef: self)
        userDetailsModel.updateTestStatus(testId: testID!, userId: userId)
        
      
    }
    
    func onFailConnected() {
        self.OnFail(message: "NO_INTERNET_CONNECTION".localized)
    }
    
    var userDetailsViewRef: IUserDetailsView!
    init(userDetailsViewRef: IUserDetailsView) {
        self.userDetailsViewRef = userDetailsViewRef
    }
    func updateTestStatus(testId: Int64, userId: String) {
        self.testID = testId
        self.userId = userId
         var check = InternetConnection.checkInternetConnection(iCheckConnection: self)
        
    }
    
    func onSuccess() {
        userDetailsViewRef.getResult()
    }
    
    func OnFail(message: String) {
        userDetailsViewRef.OnFail(message: message)
    }
    

   
    
}
