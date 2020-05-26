//
//  FindCityHeader.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 26.05.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class FindCityHeader: UITableViewCell {
    // MARK:- Views
    var cityTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .authNextGray
        textField.layer.cornerRadius = 24
        textField.font = UIFont(name: "Times", size: 22)
        return textField
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Times", size: 22)
        label.textColor = .placeholderBlack
        return label
    }()
    
    // MARK:- Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Setups
    private func setupTextField() {
        
    }
}
