//
//  CategoryFeedCollectionViewCell.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 02.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class CategoryFeedCollectionViewCell: UICollectionViewCell {
    // MARK:- Views
    lazy var contactButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .contactPurple
        button.setTitle("Связаться", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Heltevica", size: 18)
        button.layer.cornerRadius = 7
        return button
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .priceGray
        label.font = UIFont(name: "Heltevica", size: 20)
        return label
    }()
    
    lazy var videoContrainer: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    lazy var productName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Heltevica Neue", size: 24)
        return label
    }()
    
    // MARK:- Initializers
}
