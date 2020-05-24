//
//  MainViewConllectionViewCell.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 24.05.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class MainViewConllectionViewCell: UICollectionViewCell {
    // MARK:- Views
    var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 16)
        return label
    }()
    // MARK:- Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        
//        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Setups
    func setupImageView() {
        addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            iconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 35),
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 47)
        ])
    }
    
    func setupLabel() {
        addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 22),
            textLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 9),
        ])
    }

}
