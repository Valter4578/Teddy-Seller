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
            $0.top.equalTo(view)
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
}
