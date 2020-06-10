//
//  UserDetailsModel.swift
//  CheckUpEmployee
//
//  Created by kasper on 6/3/20.
//  Copyright © 2020 Mahmoud.kasper. All rights reserved.
//

import Foundation
import Alamofire
class UserDetailsModel: IUserDetailsModel {
    var userDetailsPresenterRef : IUserDetailsPresenter!
    init(userDetailsPresenterRef : IUserDetailsPresenter) {
        self.userDetailsPresenterRef = userDetailsPresenterRef
    }
    func updateTestStatus(testId: Int64) {
        var updateStatus = UpdateStatus(id: testId, status: "PendingForResult")
        let updateStatusDic = try! DictionaryEncoder.encode(updateStatus)
        //"http://checkup.somee.com/api/AnalysisService/UpdateAnalysis"
        let urlString = "\(ApiUrl.API_URL)/api/AnalysisService/UpdateTakeSampleStatus"
        Alamofire.request(urlString, method: .post , parameters: updateStatusDic , encoding: JSONEncoding.default, headers: nil).responseJSON {
                      response in
          switch response.result {
                             case .success:
                                print(response)
            self.userDetailsPresenterRef.onSuccess()
                             case .failure(let error):
                                self.userDetailsPresenterRef.OnFail(message: "An error occured please try again later")
                             }
        
                  }
    }
}
