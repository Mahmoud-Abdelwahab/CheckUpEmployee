//
//  ILogin.swift
//  CheckUpEmployee
//
//  Created by kasper on 6/1/20.
//  Copyright © 2020 Mahmoud.kasper. All rights reserved.
//

import Foundation
protocol ILoginVC : IBase {
    func userValidation ()
}
protocol ILoginPresenter {
    func checkUser(email: String,password: String)
    func onSuccess()
    func onFail(message: String)
}
protocol ILoginModel {
    func checkUser(email: String,password: String)
}
