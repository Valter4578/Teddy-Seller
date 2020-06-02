//
//  CategoryFeedCollectionViewController+Setup.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 02.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

extension CategoryFeedCollectionViewController {
    func setupCollectionView() {
        collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(CategoryFeedCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
}
