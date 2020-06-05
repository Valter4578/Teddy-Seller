//
//  CategoryFeedCollectionViewCell.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 02.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit

class CategoryFeedHeader: UICollectionViewController {
    // MARK:- Private properties
    let cellId = "CategoryFeedHeaderCell"
    // MARK:- Properties
    var subcategories: [Category]?
    
    // MARK:- Setups
    private func setupColectionView() {
        collectionView.backgroundColor = .red
        collectionView.register(CategoryFeedHeaderCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    // MARK:- Datasource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = subcategories?.count else { return 0 }
        return count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryFeedHeaderCollectionViewCell
        cell.layer.cornerRadius = 24
        cell.titleLabel.text = subcategories?[indexPath.item].title
        return cell
    }
    
    // MARK:- Inits
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        
        setupColectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
