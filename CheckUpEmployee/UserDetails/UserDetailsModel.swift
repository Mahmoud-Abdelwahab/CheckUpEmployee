//
//  UserDetailsModel.swift
//  CheckUpEmployee
//
//  Created by kasper on 6/3/20.
//  Copyright © 2020 Mahmoud.kasper. All rights reserved.
//

import Foundation
import Alamofire
import Firebase
class UserDetailsModel: IUserDetailsModel {
    var userDetailsPresenterRef : IUserDetailsPresenter!
    var ref: DatabaseReference!
    init(userDetailsPresenterRef : IUserDetailsPresenter) {
        self.userDetailsPresenterRef = userDetailsPresenterRef
        ref = Database.database().reference()
    }
    func updateTestStatus(testId: Int64, userId: String) {
        var updateStatus = UpdateStatus(id: testId, status: "PendingForResult")
        let updateStatusDic = try! DictionaryEncoder.encode(updateStatus)
        //"http://checkup.somee.com/api/AnalysisService/UpdateAnalysis"
        let urlString = "\(ApiUrl.API_URL)/api/AnalysisService/UpdateTakeSampleStatus"
        Alamofire.request(urlString, method: .post , parameters: updateStatusDic , encoding: JSONEncoding.default, headers: nil).responseJSON {
                      response in
          switch response.result {
                             case .success:
                                print(response)
                                self.ref.child("Notification").child(userId).setValue(["getNotified": self.ref.childByAutoId().key!])
            self.userDetailsPresenterRef.onSuccess()
                             case .failure(let error):
                                self.userDetailsPresenterRef.OnFail(message: "An error occured please try again later")
                             }
        
                  }
    }
}
