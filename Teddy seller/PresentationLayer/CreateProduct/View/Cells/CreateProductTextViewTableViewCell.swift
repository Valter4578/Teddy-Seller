//
//  CreateProductTextViewTableViewCell.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 09.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class CreateProductTextViewTableViewCell: UITableViewCell {
    // MARK:- Views
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Heltevica Neue", size: 24)
        label.textAlignment = .left
        label.text = "Lorem ispum"
        return label
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .authNextGray
        return textView
    }()
    
    // MARK:- Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Setups
    private func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [label, textView])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints { maker in
            maker.leading.equalTo(self).offset(20)
            maker.trailing.equalTo(self).offset(-20)
            maker.top.equalTo(self).offset(10)
            maker.bottom.equalTo(self).offset(-10)
        }
    }
    
    // MARK:- Overriden methods
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textView.layer.cornerRadius = 24
        textView.layer.borderColor = UIColor.plusContainerBorderGray.cgColor
    }
}
