//
//  UserDetailsPresenter.swift
//  CheckUpEmployee
//
//  Created by kasper on 6/3/20.
//  Copyright © 2020 Mahmoud.kasper. All rights reserved.
//

import Foundation
class UserDetailsPresenter: IUserDetailsPresenter {
    var userDetailsViewRef: IUserDetailsView!
    init(userDetailsViewRef: IUserDetailsView) {
        self.userDetailsViewRef = userDetailsViewRef
    }
    func updateTestStatus(testId: Int64) {
        var userDetailsModel = UserDetailsModel(userDetailsPresenterRef: self)
        userDetailsModel.updateTestStatus(testId: testId)
    }
    
    func onSuccess() {
        userDetailsViewRef.getResult()
    }
    
    func OnFail(message: String) {
        userDetailsViewRef.OnFail(message: message)
    }
    

   
    
}
