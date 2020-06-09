//
//  IEmployeeStatus.swift
//  CheckUpEmployee
//
//  Created by kasper on 6/1/20.
//  Copyright © 2020 Mahmoud.kasper. All rights reserved.
//

import Foundation

protocol  IEmployeeRequestsView :IBase{
    func OnReceiveUserRequests(Requests : [FullUser])
    func OnFail(message :String)
}

protocol  IEmployeeRequestsPresenter :IBase , ICheckConnection {
    func getUserRequests()
    func OnReceiveUserRequests(Requests : [FullUser])
      func OnFail(message :String)
}

protocol  IEmployeeRequestsModel  {
    func getUserRequests()
}
