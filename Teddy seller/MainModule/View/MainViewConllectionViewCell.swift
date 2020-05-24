//
//  MainViewConllectionViewCell.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 24.05.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit

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
        label.numberOfLines = 0
        return label
    }()
    // MARK:- Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        print(frame.width)
        print(frame.height)
        
        setupImageView()
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Setups
    func setupImageView() {
        addSubview(iconImageView)
        
        iconImageView.snp.makeConstraints { (maker) in
            maker.centerY.equalTo(self).offset(-5)
            maker.centerX.equalTo(self)
            maker.height.equalTo(90)
            maker.width.equalTo(90)
        }
    }
    
    func setupLabel() {
        addSubview(textLabel)
        
        textLabel.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(self)
            maker.top.equalTo(iconImageView.snp.bottom).offset(5)
            maker.bottom.equalTo(self)
        }
    }
}
