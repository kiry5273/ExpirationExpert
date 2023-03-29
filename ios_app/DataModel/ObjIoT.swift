//
//  ObjIot.swift
//  ios_app
//
//  Created by Kenneth Wu on 2022/12/15.
//

import Foundation

struct JsonData: Decodable, Encodable{
    var created_at: String
    var entry_id: Int
    var field1: String
    var field2: String
    var field3: String
}

struct JsonData2: Decodable, Encodable{
    var created_at: String
    var entry_id: Int
    var field1: Int
    var field2: Int
    var field3: Int
}
