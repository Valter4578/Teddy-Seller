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
    
    // Mock data 
    private let products: [Product] = [Product(title: "Mackbook", price: 90000, category: .electronics),
                               Product(title: "iPhone", price: 40000, category: .electronics),
                               Product(title: "Apple watch", price: 50000, category: .electronics)]
    
    // MARK:- Properties
    var category: Categories? 
    
    // MARK:- Views
    var header: CategoryFeedCollectionViewHeader!
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        collectionView.backgroundColor = .mainBlue
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return products.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryFeedCollectionViewCell
        cell.layer.cornerRadius = 20
        cell.productName.text = products[indexPath.row].title
        cell.priceLabel.text = "\(products[indexPath.row].price)₽"
        
        return cell
    }
    
//    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! CategoryFeedCollectionViewHeader
//        
//        return header
//    }

}

extension CategoryFeedCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 38, height: 320)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 19
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
