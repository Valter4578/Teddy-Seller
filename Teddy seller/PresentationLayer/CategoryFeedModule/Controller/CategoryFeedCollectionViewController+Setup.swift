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
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .mainBlue
        collectionView.register(CategoryFeedCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.leading.equalTo(view)
            $0.trailing.equalTo(view)
            $0.bottom.equalTo(bottomBar.snp.top)
        }
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
    
    func setupTopBar() {
        
        topBar.delegate = self
        
        view.addSubview(topBar)
        
        topBar.leftButton.setTitle("Снять", for: .normal)
        topBar.rightButton.setTitle("Купить", for: .normal)
        
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
        title = category?.title
    }
    
    func setupCategoryHeader() {
        header.subcategories = category?.subcategories
        
        view.addSubview(header.collectionView)
        
        header.collectionView.snp.makeConstraints {
            $0.leading.equalTo(view)
            $0.trailing.equalTo(view)
            $0.top.equalTo(topBar.snp.bottom)
            $0.bottom.equalTo(collectionView.snp.top)
            $0.height.equalTo(header.collectionView.collectionViewLayout.collectionViewContentSize).priority(999)
        }
    }
}
