//
//  FullUser.swift
//  CheckUpEmployee
//
//  Created by kasper on 6/9/20.
//  Copyright © 2020 Mahmoud.kasper. All rights reserved.
//

import Foundation
class  FullUser : Codable {
   var fireBaseUser : User?
   var UserId : String?
   var timeForTakingSample : String?
   var dateForTakingSample : String?
   var generatedCode : String?
   var TestId : Int64?
    var address : Address?
    
}

