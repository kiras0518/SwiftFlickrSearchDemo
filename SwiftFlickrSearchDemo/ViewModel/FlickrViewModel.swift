//
//  FlickrViewModel.swift
//  SwiftFlickrSearchDemo
//
//  Created by kiras on 2020/3/6.
//  Copyright © 2020 ameyo. All rights reserved.
//

import Foundation

class FlickrViewModel {
    
    var dataSource: GenericDataSource<Photo>?
    
    init(dataSource: GenericDataSource<Photo>?) {
        self.dataSource = dataSource
    }
    
    func fetchPhoto(search: String, quantity: Int) {
        FlickrSearchService.shared.fetchPhotosForSearchText(searchText: search, quantity: quantity) { (data, err) in
            
            guard let data = data else { return }
            
            if let err = err {
                
                print("fetchPhoto Error", err)
            }
            
            self.dataSource?.data.value = data
        }
    }
    
}
