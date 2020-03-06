//
//  SearchViewCell.swift
//  SwiftFlickrSearchDemo
//
//  Created by kiras on 2020/3/6.
//  Copyright © 2020 ameyo. All rights reserved.
//

import UIKit
import Kingfisher

class SearchViewCell: UICollectionViewCell {
    
    static let identifier = "SearchViewCell"
    
    override var reuseIdentifier: String? {
        return SearchViewCell.identifier
    }
    
    lazy var bgView: UIView = {
        let iv = UIView()
        iv.backgroundColor = .white
        
        return iv
    }()
    
    lazy var nameLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.text = "IMA"
        lb.numberOfLines = 1
        
        return lb
    }()
    
    lazy var mainImage: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .green
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    fileprivate func setupView() {
        
        addSubview(bgView)
        bgView.fillSuperview()
        
        bgView.addSubview(mainImage)
        mainImage.anchor(top: bgView.topAnchor, leading: bgView.leadingAnchor, bottom: bgView.bottomAnchor, trailing: bgView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 40, right: 0))
        
        bgView.addSubview(nameLabel)
        nameLabel.anchor(top: mainImage.bottomAnchor, leading: bgView.leadingAnchor, bottom: bgView.bottomAnchor, trailing: bgView.trailingAnchor, padding: .init(top: 0, left: 4, bottom: 0, right: 4))
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        mainImage.image = nil
    }

    func configCell(model: Photo) {
        nameLabel.text = model.title
        guard let url = URL(string: model.imageURL) else { return }
        mainImage.kf.setImage(with: url)
    }
}
