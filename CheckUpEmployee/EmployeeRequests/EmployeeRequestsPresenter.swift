//
//  EmployeeStatusPresenter.swift
//  CheckUpEmployee
//
//  Created by kasper on 6/1/20.
//  Copyright © 2020 Mahmoud.kasper. All rights reserved.
//

import Foundation

class EmployeeRequestsPresenter:IEmployeeRequestsPresenter
{
    func OnReceiveUserRequests(Requests: [FullUser]) {
        empRequestViewRef.hideIndicator()

       empRequestViewRef.OnReceiveUserRequests(Requests: Requests)
    }
    
   
    
    var empRequestViewRef : IEmployeeRequestsView!
    init( empRequestViewRef : IEmployeeRequestsView) {
        self.empRequestViewRef = empRequestViewRef
    }
    
    func getUserRequests() {
        
               var check = InternetConnection.checkInternetConnection(iCheckConnection: self)
   
    }
    
   
    
    func OnFail(message: String) {
        
    }
    
    func showIndicator() {
        
    }
    
    func hideIndicator() {
        
    }
    
    func errorMessage(msg: String) {
        
    }
    
    func onSucessfullyConnected() {
        empRequestViewRef.showIndicator()
        var employeeRequestModel  = EmployeeRequestsModel( empRequestPresenterRef : self)
        employeeRequestModel.getUserRequests()
        
    }
    
    func onFailConnected() {
        
    }
    
    
    
    
    
}
