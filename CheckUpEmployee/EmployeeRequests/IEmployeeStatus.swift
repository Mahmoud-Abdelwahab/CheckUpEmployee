//
//  IEmployeeStatus.swift
//  CheckUpEmployee
//
//  Created by kasper on 6/1/20.
//  Copyright © 2020 Mahmoud.kasper. All rights reserved.
//

import Foundation

protocol  IEmployeeStatusView {
    func OnReceiveUserRequests(Requests : [User])
    func OnFail(message :String)
}

protocol  IEmployeeStatusPresenter :IBase , ICheckConnection {
    func getUserRequests(employeeId : String)
    func OnReceiveUserRequests(Requests : [User])
      func OnFail(message :String)
}

protocol  IEmployeeStatusModel  {
    func getUserRequests(employeeId : String)
}
