//
//  CategoryFeedCollectionViewController.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 02.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit


class CategoryFeedCollectionViewController: UICollectionViewController {
    // MARK:- Private properties
    let cellId = "CategoryFeedCollectionViewControllerCellId"
    let headerId = "CategoryFeedCollectionViewHeaderId"

    // MARK:- Views
    var header: CategoryFeedCollectionViewHeader!
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView() 
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! CategoryFeedCollectionViewHeader
        
        return header
    }

    // MARK: UICollectionViewDelegate

}
