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
        label.textColor = .priceGray
        label.textAlignment = .center
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
        label.textAlignment = .center
        label.textColor = .productGray
        return label
    }()
    
    // MARK:- Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
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
        
        productName.snp.makeConstraints {
            $0.leading.equalTo(self)
            $0.trailing.equalTo(self)
            $0.top.equalTo(self).offset(10)
            
        }
    }
    
    func setupContactButton() {
        addSubview(contactButton)
        
        contactButton.snp.makeConstraints {
            $0.width.equalTo(150)
            $0.height.equalTo(40)
            $0.trailing.equalTo(self).offset(-30)
            $0.bottom.equalTo(self).offset(-10)
        }
    }
    
    func setupVideoContainer() {
        addSubview(videoContrainer)
        
        videoContrainer.snp.makeConstraints {
            $0.leading.equalTo(self)
            $0.trailing.equalTo(self)
            $0.bottom.equalTo(contactButton.snp.top).offset(-8)
            $0.top.equalTo(productName.snp.bottom)
        }
    }
    
    func setupPriceLabel() {
        addSubview(priceLabel)
        
        priceLabel.snp.makeConstraints {
            $0.bottom.equalTo(contactButton.snp.bottom)
            $0.top.equalTo(contactButton.snp.top)
            $0.leading.equalTo(self).offset(20)
            $0.trailing.equalTo(contactButton.snp.leading).offset(-20)
        }
    }
    
}
