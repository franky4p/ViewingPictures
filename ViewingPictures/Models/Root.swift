//
//  Root.swift
//  VKApp
//
//  Created by Pavel Khlebnikov on 02.08.2021.
//

import Foundation
import Unrealm

struct Root<T: Decodable> : Decodable {
    let page: Int?
    let photos: [T]
}


