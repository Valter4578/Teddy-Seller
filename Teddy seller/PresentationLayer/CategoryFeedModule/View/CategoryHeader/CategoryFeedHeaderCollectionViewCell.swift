//
//  CategoryFeedHeaderCollectionViewCell.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 04.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit

class CategoryFeedHeaderCollectionViewCell: UICollectionViewCell {
    // MARK:- Views
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Times", size: 16)
        label.textColor = .productGray
        return label
    }()
        
    // MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Setups
    private func setupTitleLabel() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.center.equalTo(self)
        }
    }
}
