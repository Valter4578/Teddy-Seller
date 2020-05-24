//
//  MainCollectionViewController.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 24.05.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class MainCollectionViewController: UICollectionViewController {
    // MARK:- Properties
    let cellIdentifier = "MainCollectionViewCell"
    var categories = [MainCellModel(imageName: "Realty", text: "Недвижимость"),
                      MainCellModel(imageName: "Transport", text: "Транспорт"),
                      MainCellModel(imageName: "Home", text: "Для дома"),
                      MainCellModel(imageName: "Buiseness", text: "Для бизнеса"),
                      MainCellModel(imageName: "Work", text: "Работа"),
                      MainCellModel(imageName: "PersonalItems", text: "Личные вещи"),
                      MainCellModel(imageName: "Teddy", text: "Электроника"),
                      MainCellModel(imageName: "Teddy", text: "Услуги"),]

    // MARK:- Properties
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(MainViewConllectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.backgroundColor = .mainBlue
    }
    
    
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

extension MainCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, insetForSectionAt: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24, left: 31, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt: Int) -> CGFloat {
        return 50
    }
}
