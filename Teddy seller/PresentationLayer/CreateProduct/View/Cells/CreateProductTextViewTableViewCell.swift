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
    
        setupTextView()
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Setups
    private func setupTextView() {
        addSubview(textView)
        
        textView.snp.makeConstraints { maker in
            maker.leading.equalTo(self).offset(20)
            maker.trailing.equalTo(self).offset(-20)
            maker.bottom.equalTo(self).offset(-10)
            maker.height.equalTo(185)
        }
    }
    
    private func setupLabel() {
        addSubview(label)
        
        label.snp.makeConstraints { maker in
            maker.bottom.equalTo(textView.snp.top).offset(-10)
            maker.leading.equalTo(self).offset(20)
            maker.trailing.equalTo(self).offset(-20)
        }
    }
    
    // MARK:- Overriden methods
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textView.layer.cornerRadius = 24
        textView.layer.borderColor = UIColor.plusContainerBorderGray.cgColor
    }
}
