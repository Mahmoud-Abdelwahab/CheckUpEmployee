//
//  UserIds.swift
//  CheckUpEmployee
//
//  Created by kasper on 6/7/20.
//  Copyright © 2020 Mahmoud.kasper. All rights reserved.
//

import Foundation

struct UserIds : Codable{
    
    var TestId: Int64?
    var UserId: String?
    var address : Address?
    var timeForTakingSample : String?
    var dateForTakingSample : String?
    var generatedCode : String?
}
