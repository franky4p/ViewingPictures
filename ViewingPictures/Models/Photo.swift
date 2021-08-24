//
//  User.swift
//  Task1
//
//  Created by macbook on 01.11.2020.
//

import Foundation
import Unrealm

struct Photos: Decodable, Realmable {
    
    static func primaryKey() -> String? {
        return "id"
    }
    
    private enum CodingKeys : String, CodingKey {
        case photographer = "photographer"
        case id = "id"
        case photo = "url"
        case source = "src"
    }
    var photographer: String = ""
    var id: Int?
    var photo: String?
    var source: Source?
}

struct Source: Decodable, Realmable {
    var original: String?
    var small: String?
}
