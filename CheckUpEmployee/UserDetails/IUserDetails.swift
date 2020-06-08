//
//  IUserDetails.swift
//  CheckUpEmployee
//
//  Created by kasper on 6/3/20.
//  Copyright © 2020 Mahmoud.kasper. All rights reserved.
//

import Foundation

protocol  IUserDetailsView {
//    func OnReceiveUser(user : User)
    func getResult()
    func OnFail(message :String)
}

protocol  IUserDetailsPresenter :IBase , ICheckConnection {
    func updateTestStatus(testId : Int64)
    func onSuccess()
    func OnFail(message :String)
}

protocol  IUserDetailsModel  {
    func updateTestStatus(testId : Int64)
    //  i think that no need for model here
    // i might use presenter only to do my logic
}
