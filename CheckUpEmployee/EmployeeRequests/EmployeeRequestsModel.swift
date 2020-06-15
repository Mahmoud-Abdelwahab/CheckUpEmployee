//
//  EmployeeStatusModel.swift
//  CheckUpEmployee
//
//  Created by kasper on 6/1/20.
//  Copyright © 2020 Mahmoud.kasper. All rights reserved.
//

import Foundation
import Alamofire
import Firebase
import FirebaseFirestore
import SDWebImage
class EmployeeRequestsModel : IEmployeeRequestsModel
{
    
    var ref: DatabaseReference!
    
    var userRequestsList : [FullUser]?
    
    var empRequestPresenterRef : IEmployeeRequestsPresenter!
    init( empRequestPresenterRef : IEmployeeRequestsPresenter) {
        self.empRequestPresenterRef = empRequestPresenterRef
        
        
        ref = Database.database().reference(withPath:"Users");
        userRequestsList = [FullUser]()
    }
    var myClosureEmpIsFound :(()->())?
    func getUserRequests() {
        
       // var apiData = [UserIds]()
        //  let employeeID = Auth.auth().currentUser!.uid
        // let urlString = "http://www.checkup.somee.com/api/AnalysisService/GetUsersByEmployeeId"
        //   let params: [String: String] = ["Id": testId]
        
        let id = Auth.auth().currentUser!.uid
        ///8kYuK9fL2xeXBHtAh7ldnBcaiTD3
        let urlString = "http://checkuplive.somee.com/api/analysisService/GetUsersByEmployeeId?employeeId=\(id)"
        Alamofire.request(urlString, method: .get,encoding: JSONEncoding.default, headers: nil).responseString {
            response in
            
//            guard response.value != nil
//                else { return }
            print(response)
            
            do {
                
                let apiData =  try JSONDecoder().decode([UserIds].self, from: response.data!)
                if apiData.isEmpty == true{
                    self.empRequestPresenterRef.OnReceiveUserRequests(Requests: [] )
                }
                for item in apiData
                {
                    var fullUser = FullUser()
                    fullUser.UserId = item.UserId
                    fullUser.TestId = item.TestId
                    fullUser.timeForTakingSample = item.timeForTakingSample
                    fullUser.dateForTakingSample = item.dateForTakingSample
                    fullUser.generatedCode = item.generatedCode
                    fullUser.address = item.address ;
                     var  user = User()
                     fullUser.fireBaseUser = user;
                    self.userRequestsList?.append(fullUser)
                }
                
                
                
                
                self.getUsersList()
                
                
                
                // self.empRequestPresenterRef.OnReceiveUserRequests(Requests: [User])
            }catch let error{
                
                print(error)
            }
            
            
            
        }
        
    }
    
    
    
    //
    //            guard let userId = Auth.auth().currentUser?.uid else {
    //                        print("loge in   user id  is empty  .... ")
    //                     return
    //                  }
    //
    func getUsersList(){
        
        // DispatchQueue.background(background: { },complition : {})
        
        var counter : Int  = 0 ;
        guard  let userRequestsListExists = userRequestsList
            else{
                
                //** * * here if no requests for employee do somthing  ** ** * * * * *  //
//                empRequestPresenterRef.OnFail(message: "No Requests For you ")
                self.empRequestPresenterRef.OnReceiveUserRequests(Requests: [] )
                return
        }
        
        for apiUser in userRequestsListExists
        {
            
            ref.child(apiUser.UserId!).observe(.value){
                SnapShoot in
                
                guard  let values = SnapShoot.value as?[String:Any] else{
                    self.empRequestPresenterRef.OnFail(message: "No Requests For you ")
                    return
                    
                }
                // let values = SnapShoot.value as![String:Any]
                do {
                    
                    self.userRequestsList![counter].fireBaseUser?.name = values["name"]as? String ?? ""
                    self.userRequestsList![counter].fireBaseUser?.email = values["email"]as? String ?? ""
                    self.userRequestsList![counter].fireBaseUser?.birthdate = values["birthdate"]as? String ?? ""
                    self.userRequestsList![counter].fireBaseUser?.insurance = values["insurance"]as? String ?? ""
                    self.userRequestsList![counter].fireBaseUser?.imagePath = values["imagePath"]as? String ?? ""
                    
                    let phones = values["phone"] as! NSArray
                    var phoneArr = [Phone]()
                    for phone in phones {
                        let phoneDIc = phone as! NSDictionary
                        var phone = Phone()
                        phone.isLand = phoneDIc.value(forKey: "isLand") as! Bool
                        phone.number = phoneDIc.value(forKey: "number") as! String
                        phoneArr.append(phone)
                    }

                    
                    self.userRequestsList![counter].fireBaseUser?.phone = phoneArr
                    
                    
                    //  print("the name \(name) the user \(email) complithios is \(name)")
                
                    counter = counter + 1
                    if counter >= userRequestsListExists.count{
                        self.empRequestPresenterRef.OnReceiveUserRequests(Requests: self.userRequestsList ?? [] )
                    }
                   
                    
                } catch let error {
                    print("error converting \(error)")
                }
            
            }// firebase closure
            
        }// loop
        
        
        
        
        
        
    }//
    
    
    
}

