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
        return label
    }()
    // MARK:- Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        print(frame.height)
        print(frame.width)
        
//        setupImageView()
//        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Setups
    func setupImageView() {
        addSubview(iconImageView)
        
        iconImageView.snp.makeConstraints { (maker) in
            maker.top.equalTo(self).offset(17)
            maker.right.equalTo(self).offset(-31)
            maker.left.equalTo(self).offset(31)
            maker.bottom.equalTo(self).offset(-47)
        }
        
    }
    
    func setupLabel() {
        addSubview(textLabel)
        
        textLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(iconImageView.snp.bottom).offset(9)
            maker.left.equalTo(self).offset(19)
            maker.right.equalTo(self).offset(-18)
            maker.bottom.equalTo(self).offset(-22)
        }
    }

}
