//
//  Photo.swift
//  SwiftFlickrSearchDemo
//
//  Created by kiras on 2020/3/6.
//  Copyright © 2020 ameyo. All rights reserved.
//

import Foundation

struct Photo: Codable {
    let id: String?
    let owner: String?
    let secret: String?
    let server: String?
    let farm: Int?
    let title: String?
    let ispublic: Int?
    let isfriend: Int?
    let isfamily: Int?
    
    var imageURL: String {
        
        guard let farm = farm, let server = server, let id = id,
        let sercet = secret else { return "" }
        
        let urlString = String("https://farm\(farm).staticflickr.com/\(server)/\(id)_\(sercet)_m.jpg")
        return urlString
    }
}
