//
//  SearchViewController+Setup.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 20.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit

extension SearchViewController {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorColor = .clear
        
        tableView.allowsSelection = false
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.leading.equalTo(view)
            $0.trailing.equalTo(view)
            $0.bottom.equalTo(findButton.snp.top)
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    func setupFindButton() {
        view.addSubview(findButton)
        
        findButton.snp.makeConstraints { maker in
            maker.bottom.equalTo(view)
            maker.leading.equalTo(view)
            maker.trailing.equalTo(view)
            maker.height.equalTo(78)
        }
        
    }
    
    func setupPickerView() {
        if let index = cellTypes.lastIndex(of: .textField(title: "Материал стен", serverName: "material", needsOnlyNumbers: false)) {
            materialsPickerView = UIPickerView()
            
            materialsPickerView?.delegate = self
            materialsPickerView?.dataSource = self
            
            guard let materialCell = cells[index] as? TextFieldTableViewCell else { return }
            materialCell.textField.inputView = materialsPickerView
            materialsPickerView?.clipsToBounds = true
        }
    }
    
    func setupNavigationController() {
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.clipsToBounds = false
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        let backImage = UIImage(named: "back")
        let backItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(didTapBack))
        navigationItem.leftBarButtonItem = backItem
    }
}
