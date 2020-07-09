//
//  CategoryFeedViewController+Setup.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 02.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit

extension CategoryFeedViewController {
    func setupTableViewConstraints() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.leading.equalTo(view)
            $0.trailing.equalTo(view)
            if needsToPresentBottomBar {
                $0.bottom.equalTo(bottomBar.snp.top)
            } else {
                $0.bottom.equalTo(view.safeAreaLayoutGuide)
            }
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorColor = .clear
        tableView.backgroundColor = .mainBlue

        tableView.register(CategoryFeedTableViewCell.self, forCellReuseIdentifier: cellId)
        
        setupTableViewConstraints()
    }
    
    func setupBottomBar() {
        view.addSubview(bottomBar)
        
        bottomBar.snp.makeConstraints {
            $0.leading.equalTo(view)
            $0.trailing.equalTo(view)
            $0.bottom.equalTo(view)
            $0.height.equalTo(78)
        }
    }
    
    func setupTopBar(leftTitle: String, rightTitle: String) {
        topBar.delegate = self
        
        view.addSubview(topBar)
        
        topBar.leftButton.setTitle(leftTitle, for: .normal)
        topBar.rightButton.setTitle(rightTitle, for: .normal)
        
        topBar.snp.makeConstraints {
            $0.leading.equalTo(view)
            $0.trailing.equalTo(view)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
    }
    
    func setupNavigationBar() {
        let leftBarItem = UIBarButtonItem(customView: arrowView)
        navigationItem.leftBarButtonItem = leftBarItem
        title = currentCategory?.title
        
        let searchImage = UIImage(named: "search")
        let rightBarItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(presentSearch))
        rightBarItem.tintColor = .white
        navigationItem.rightBarButtonItem = rightBarItem
    }
    
    func setupCategoryHeader() {
        header.delegate = self
        
        header.subcategories = currentCategory?.subcategories
        
        view.addSubview(header.collectionView)
        header.collectionView.snp.remakeConstraints {
            $0.leading.equalTo(view)
            $0.trailing.equalTo(view)
            
            if needsToPresentTopBar {
                $0.top.equalTo(topBar.snp.bottom)
            } else {
                $0.top.equalTo(view.safeAreaLayoutGuide)
            }
            
            $0.bottom.equalTo(tableView.snp.top)
            
            if (currentCategory?.subcategories?.count ?? 0) > 0 {
                $0.height.equalTo(header.collectionView.collectionViewLayout.collectionViewContentSize).priority(999)
            } else {
                $0.height.equalTo(10)
            }
            header.collectionView.layoutIfNeeded()
        }
        
    }
}
