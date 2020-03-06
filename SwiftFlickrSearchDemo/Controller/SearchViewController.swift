//
//  SearchViewController.swift
//  SwiftFlickrSearchDemo
//
//  Created by kiras on 2020/3/6.
//  Copyright © 2020 ameyo. All rights reserved.
//

import UIKit

struct SearchParameters {
    var search: String
    var amount: Int
}

class SearchViewController: UICollectionViewController {
    
    static func initiate(paramters: SearchParameters) -> SearchViewController {
        let vc = SearchViewController()
        let dataSource = SearchDataSource()
        vc.viewModel = FlickrViewModel(dataSource: dataSource)
        vc.parameters = paramters
        return vc
    }

    private var viewModel: FlickrViewModel?
    private var parameters: SearchParameters?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupCollectionView()
        viewModel?.fetchPhoto(search: parameters?.search ?? "", quantity: parameters?.amount ?? 0)
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupNav() {
        self.navigationItem.title = "搜尋結果: \(parameters?.search ?? "")"
    }
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .yellow
        
        collectionView.register(SearchViewCell.self, forCellWithReuseIdentifier: SearchViewCell.identifier)
        
        collectionView.alwaysBounceVertical = true
        //collectionView.contentInset = .init(top: 8, left: 4, bottom: 8, right: 4)
        
        if let dataSource =  self.viewModel?.dataSource as? UICollectionViewDataSource {
            collectionView.dataSource = dataSource
        }
        collectionView.delegate = self
        
        self.viewModel?.dataSource?.data.addAndNotify(observer: self) { [weak self] in
            
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
    }
    
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 200, height: 200)
    }
    
}

