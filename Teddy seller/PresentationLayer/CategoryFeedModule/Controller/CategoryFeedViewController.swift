//
//  CategoryFeedViewController.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 02.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class CategoryFeedViewController: UIViewController {
    // MARK:- Private properties
    let cellId = "CategoryFeedCollectionViewControllerCellId"
    let headerId = "CategoryFeedCollectionViewHeaderId"
    
    // MARK:- Properties
    var category: Category?
    
    // MARK:- Views
    var header: CategoryFeedHeader = {
        let layout = UICollectionViewFlowLayout()
        let header = CategoryFeedHeader(collectionViewLayout: layout)
        return header
    }()
    var bottomBar: BottomBar = BottomBar()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .mainBlue
        return collectionView
    }()
    
    var arrowView: ArrowView = {
        let view = ArrowView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        view.transform = CGAffineTransform(rotationAngle: -(.pi/2))
        return view
    }()
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapBack))
        arrowView.addGestureRecognizer(gestureRecognizer)
        
        setupNavigationBar()
        setupBottomBar()
        setupCollectionView()
        setupCategoryHeader()
    }
    
    // MARK:- Selectors
    @objc func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: UICollectionViewDataSource
extension CategoryFeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let products = category?.products else { return 0 }
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryFeedCollectionViewCell
        cell.layer.cornerRadius = 20
        
        if let product = category?.products?[indexPath.item] {
            cell.productName.text = product.title
            cell.priceLabel.text = "\(product.price)₽"
        }
        
        return cell
    }
}

extension CategoryFeedViewController: UICollectionViewDelegateFlowLayout {
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
