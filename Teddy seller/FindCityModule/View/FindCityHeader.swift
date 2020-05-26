//
//  FindCityHeader.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 26.05.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit

class FindCityHeader: UITableViewHeaderFooterView {
    // MARK:- Views
    var cityTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .authNextGray
        textField.layer.cornerRadius = 12
        textField.font = UIFont(name: "Times", size: 22)
        return textField
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Times", size: 22)
        label.textColor = .placeholderBlack
        label.text = "Начните вводить название города"
        return label
    }()
    
    // MARK:- Initializers
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        setupStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Setups
    private func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [label, cityTextField])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints { (maker) in
            maker.leading.equalTo(contentView).offset(20)
            maker.trailing.equalTo(contentView).offset(-20)
            maker.bottom.equalTo(contentView).offset(-20)
            maker.top.equalTo(contentView).offset(15)
        }
    }
}
