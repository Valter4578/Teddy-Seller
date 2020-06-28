//
//  CategoryFeedCollectionViewCell.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 02.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation

final class CategoryFeedCollectionViewCell: UICollectionViewCell {
    // MARK:- Properties
    var product: Product? {
        didSet {
            if let product = product {
                priceLabel.font  = UIFont(name: "Helvetica Neue", size: 16.0)
                priceLabel.text = "Цена: " + String(product.price) + " ₽"
                productName.text = product.title
            }
        }
    }
    
    // MARK:- Views
    lazy var contactButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .contactPurple
        button.setTitle("Связаться", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Heltevica Neue", size: 24)
        button.layer.cornerRadius = 7
        button.addTarget(self, action: #selector(didTapContact), for: .touchUpInside)
        return button
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .priceGray
        label.font = UIFont(name: "Heltevica", size: 20)
        label.textColor = .priceGray
        label.textAlignment = .natural
        label.numberOfLines = 1
        return label
    }()
    
    lazy var videoContrainer: PlayerView = {
        let view = PlayerView()
        view.player = AVPlayer()
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
            $0.width.equalTo(130)
            $0.height.equalTo(40)
            $0.trailing.equalTo(self).offset(-25)
            $0.bottom.equalTo(self).offset(-10)
        }
    }
    
    func setupVideoContainer() {
        addSubview(videoContrainer)
        
        videoContrainer.snp.makeConstraints {
            $0.leading.equalTo(self)
            $0.trailing.equalTo(self)
            $0.bottom.equalTo(contactButton.snp.top).offset(-8)
            $0.top.equalTo(productName.snp.bottom).offset(8)
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
    
    @objc func didTapContact() {
        guard let phoneNumber = product?.phoneNumber,
            let url = URL(string: "tel://\(phoneNumber)") else { return }
        UIApplication.shared.open(url)
    }
    
}
