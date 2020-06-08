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
class EmployeeRequestsModel : IEmployeeRequestsModel
{


        var db: Firestore!
 
        var reqIdList : [String]
        var empRequestPresenterRef : IEmployeeRequestsPresenter!
           init( empRequestPresenterRef : IEmployeeRequestsPresenter) {
               self.empRequestPresenterRef = empRequestPresenterRef
            reqIdList = [String]()

            let settings = FirestoreSettings()
            Firestore.firestore().settings = settings
            db = Firestore.firestore()
           }
    var myClosureEmpIsFound :(()->())?
        func getUserRequests() {
           
            
                  //  let employeeID = Auth.auth().currentUser!.uid
                       let urlString = "http://www.checkup.somee.com/api/AnalysisService/GetUsersByEmployeeId"
                          //   let params: [String: String] = ["Id": testId]
                          
                       
         //http://www.checkup.somee.com/api/AnalysisService/GetUsersByEmployeeId?employeeId=2F7ztgZ0JLMHohwNPSPuABoNJPT2
             Alamofire.request(urlString, method: .get,parameters:["employeeId" : Auth.auth().currentUser!.uid]  , headers: nil).responseString {
                                                  response in
                 
                guard response.value != nil
                  else { return }
                  print(response)
                
                 do {
                    
            let requestsIds =  try JSONDecoder().decode([UserIds].self, from: response.data!)
                     self.getUserList(reqIdList: requestsIds)
                        print(requestsIds)
                         print(requestsIds)
                         print(requestsIds)
                   

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
        func getUserList(reqIdList : [UserIds]){
             

            for user in  reqIdList
            {
                 db.collection("users").document(user.UserId!).getDocument {
                          (document  ,error) in
                      print("document*******")
                                 print(document)
                      print("document******")
//                  do {
//
//                     let requestsIds =  try JSONDecoder().decode([UserIds].self, from: document.data!)
//                      print(requestsIds)
//
//                     self.getUserList(reqIdList: requestsIds)
//
//                   // self.empRequestPresenterRef.OnReceiveUserRequests(Requests: [User])
//                  }catch let error{
//
//                   print(error)
//                  }
                      
                 
              
                             }
                         
                  
            }
            
            
            
            
            
            
        }//
        
        
        
    }

            


