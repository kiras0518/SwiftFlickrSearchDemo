//
//  SearchDataSource.swift
//  SwiftFlickrSearchDemo
//
//  Created by kiras on 2020/3/6.
//  Copyright © 2020 ameyo. All rights reserved.
//

import UIKit

class SearchDataSource: GenericDataSource<Photo>, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchViewCell.identifier, for: indexPath) as? SearchViewCell
        
        let model = self.data.value[indexPath.row]
        cell?.configCell(model: model)
        
        return cell ?? UICollectionViewCell()
    }
    
}


