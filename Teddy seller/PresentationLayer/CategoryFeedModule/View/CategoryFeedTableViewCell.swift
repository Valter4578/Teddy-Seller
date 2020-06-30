//
//  CategoryFeedTableViewCell.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 30.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit

class CategoryFeedTableViewCell: UITableViewCell {
    // MARK:- Views
    let productItem = ProductItem()
    
    // MARK:- Properties
    
    // MARK:- Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .mainBlue
        
        setupProductItem()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Setups
    private func setupProductItem() {
        addSubview(productItem)
        
        productItem.snp.makeConstraints { maker in
            maker.width.equalTo(340)
            maker.height.equalTo(250)
            maker.center.equalTo(self)
        }
    }
    
    // MARK:- Lifecycle
    override func layoutSubviews() {
        productItem.layer.cornerRadius = 12
    }
}
