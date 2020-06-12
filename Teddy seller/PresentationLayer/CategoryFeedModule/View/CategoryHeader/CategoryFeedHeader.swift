//
//  CategoryFeedCollectionViewCell.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 02.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit

protocol CategoryFeedHeaderDelegate: class {
    func passSelectedCategory(_ category: Category)
}

class CategoryFeedHeader: UICollectionViewController {
    // MARK:- Private properties
    let cellId = "CategoryFeedHeaderCell"
    // MARK:- Properties
    weak var delegate: CategoryFeedHeaderDelegate!
    
    var subcategories: [Category]?
    var selectedCategory: Category?
    
    // MARK:- Setups
    private func setupColectionView() {
        collectionView.backgroundColor = .mainBlue
        collectionView.register(CategoryFeedHeaderCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    // MARK:- Datasource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = subcategories?.count else { return 0 }
        return count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryFeedHeaderCollectionViewCell
        cell.layer.cornerRadius = 12
        cell.titleLabel.text = subcategories?[indexPath.item].title
        return cell
    }
    
    // MARK:- Delegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(subcategories?[indexPath.item])
        guard let selectedSubcategory = subcategories?[indexPath.item] else { return }
        delegate.passSelectedCategory(selectedSubcategory)
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

extension CategoryFeedHeader: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 155, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
}
