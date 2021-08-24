//
//  Root.swift
//  VKApp
//
//  Created by Pavel Khlebnikov on 02.08.2021.
//

import Foundation
import Unrealm

struct Root<T: Decodable> : Decodable {
    private enum CodingKeys : String, CodingKey {
        case page = "page"
        case photos = "photos"
        case nextPage = "next_page"
    }
    let page: Int?
    let nextPage: String?
    let photos: [T]
}


