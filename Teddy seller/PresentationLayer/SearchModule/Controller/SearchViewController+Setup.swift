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
}
