//
//  HomeViewController.swift
//  SwiftFlickrSearchDemo
//
//  Created by kiras on 2020/3/6.
//  Copyright © 2020 ameyo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var contentTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.placeholder = "搜尋內容"
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.backgroundColor = .lightGray
        
        return textField
    }()
    lazy var numberTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.placeholder = "每頁呈現數量"
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.backgroundColor = .lightGray
        
        return textField
    }()
    
    lazy var searchBtn: UIButton = {
        let btn = UIButton()
        
        btn.setTitle("搜尋", for: .normal)
        btn.addTarget(self, action: #selector(didClick), for: .touchUpInside)
        
        return btn
    }()
    
    @objc func didClick() {
        
        guard let searchText = contentTextField.text,
            let numberText = numberTextField.text,
            let quantity = Int(numberText) else { return }
        
        let searchController = SearchViewController.initiate(paramters: SearchParameters(search: searchText, amount: quantity))
        self.navigationController?.pushViewController(searchController, animated: true)
    }
    
    fileprivate func setupView() {
        // Do any additional setup after loading the view.
        let infoStackView = UIStackView(arrangedSubviews: [contentTextField, numberTextField])
        infoStackView.axis = .vertical
        infoStackView.spacing = 20
        infoStackView.alignment = .fill
        infoStackView.distribution = .fillEqually
        
        view.addSubview(infoStackView)
        infoStackView.centerInSuperview()
        infoStackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20), size: .init(width: 0, height: 100))
        
        view.addSubview(searchBtn)
        searchBtn.anchor(top: infoStackView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 30, left: 20, bottom: 0, right: 20))
    }
    
    func setupNav() {
        self.navigationItem.title = "搜尋輸入頁"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        //self.tabBarItem.title = "Apps"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNav()
        setupView()
        checkStatus()
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        print("textField.text, \(textField.text), string \(string)")
        
        let contentText = contentTextField.text?.isEmpty ?? false
        let numberText = numberTextField.text?.isEmpty ?? false

        if (!contentText) && (!numberText) {
            print("true")
            checkStatus(isEnabled: true)
        } else {
            print("false")
            checkStatus(isEnabled: false)
        }
        
        return true
    }
}

extension HomeViewController {
    
    private func checkStatus(isEnabled: Bool = false) {
        let titleColor: UIColor = isEnabled ? .white : .white
        
        searchBtn.isEnabled = isEnabled
        searchBtn.setTitleColor(titleColor, for: .normal)
        searchBtn.backgroundColor = isEnabled ? .systemBlue : .lightGray
    }
}
