//
//  MainCollectionViewController.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 24.05.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class MainCollectionViewController: UICollectionViewController {
    // MARK:- Views
    var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.backgroundColor = .black
        
        return navigationBar
    }()
    
    // MARK:- Properties
    let cellIdentifier = "MainCollectionViewCell"
    private let sectionInsets = UIEdgeInsets(top: 24.0,
                                             left: 31.0,
                                             bottom: 33.0,
                                             right: 31.0)
    
    var categories = [MainCellModel(imageName: "Realty", text: "Недвижимость"),
                      MainCellModel(imageName: "Realty", text: "Транспорт"),
                      MainCellModel(imageName: "Realty", text: "Для дома"),
                      MainCellModel(imageName: "Realty", text: "Для бизнеса"),
                      MainCellModel(imageName: "Realty", text: "Работа"),
                      MainCellModel(imageName: "Realty", text: "Личные вещи"),
                      MainCellModel(imageName: "Realty", text: "Электроника"),
                      MainCellModel(imageName: "Realty", text: "Услуги"),]

    // MARK:- Properties
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(MainViewConllectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.backgroundColor = .mainBlue
    }
    
    // MARK:- CollectionViewDatasource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MainViewConllectionViewCell {
            cell.textLabel.text = categories[indexPath.item].text
            cell.iconImageView.image = UIImage(named: categories[indexPath.item].imageName)
            cell.layer.cornerRadius = 24
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK:- CollectionViewDelegateFlowLayout
extension MainCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (2 + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / 2

        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, insetForSectionAt: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt: Int) -> CGFloat {
        return sectionInsets.left
    }
}
