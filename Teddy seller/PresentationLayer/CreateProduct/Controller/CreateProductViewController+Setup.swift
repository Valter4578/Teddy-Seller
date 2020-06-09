//
//  CreateProductViewController+Setup.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 08.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit

extension CreateProductViewController {
    func setupAddButton() {
        view.addSubview(addButton)
        
        addButton.snp.makeConstraints {
            $0.leading.equalTo(view)
            $0.trailing.equalTo(view)
            $0.bottom.equalTo(view)
            $0.height.equalTo(78)
        }
    }
    
    func setupNavigationBar() {
        let leftBarItem = UIBarButtonItem(customView: arrowView)
        navigationItem.leftBarButtonItem = leftBarItem
        title = category?.title
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { maker in
            maker.bottom.equalTo(addButton.snp.top)
            maker.leading.equalTo(view)
            maker.trailing.equalTo(view)
            maker.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
