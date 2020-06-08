//
//  DictionaryEncoder.swift
//  CheckUpEmployee
//
//  Created by Hassan Khamis on 6/4/20.
//  Copyright © 2020 Mahmoud.kasper. All rights reserved.
//

import Foundation
struct DictionaryEncoder {
    static func encode<T>(_ value: T) throws -> [String: Any] where T: Encodable {
        let jsonData = try JSONEncoder().encode(value)
        return try JSONSerialization.jsonObject(with: jsonData) as? [String: Any] ?? [:]
    }
}
