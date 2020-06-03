//
//  CategoryFeedCollectionViewCell.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 02.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit

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
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupProductNameLabel()
        setupContactButton()
        setupVideoContainer()
        setupPriceLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Setups
    func setupProductNameLabel() {
        addSubview(productName)
        
        productName.snp.makeConstraints { maker in
            maker.top.equalTo(self).offset(10)
            maker.centerX.equalTo(self)
            maker.bottom.equalTo(videoContrainer.snp.top)
        }
    }
    
    func setupVideoContainer() {
        addSubview(videoContrainer)
        
        videoContrainer.snp.makeConstraints { maker in
            maker.leading.equalTo(self)
            maker.trailing.equalTo(self)
            maker.bottom.equalTo(contactButton.snp.top)
        }
    }
    
    func setupPriceLabel() {
        addSubview(priceLabel)
        
        priceLabel.snp.makeConstraints { maker in
            maker.top.equalTo(contactButton.snp.top)
            maker.bottom.equalTo(contactButton.snp.bottom)
            maker.leading.equalTo(videoContrainer.snp.leading)
            maker.trailing.equalTo(videoContrainer.snp.trailing)
        }
    }
    
    func setupContactButton() {
        addSubview(contactButton)
        
        contactButton.snp.makeConstraints { maker in
            maker.trailing.equalTo(self).offset(30)
            maker.bottom.equalTo(self).offset(10)
            maker.height.equalTo(40)
            maker.width.equalTo(150)
        }
    }
}
