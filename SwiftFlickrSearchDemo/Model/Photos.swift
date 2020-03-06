//
//  Photos.swift
//  SwiftFlickrSearchDemo
//
//  Created by kiras on 2020/3/6.
//  Copyright © 2020 ameyo. All rights reserved.
//

import Foundation

struct Photos: Codable {
    let page: Int?
    let pages: Int?
    let perpage: Int?
    let total: String?
    let photo: [Photo]?
}
