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
        
        backgroundColor = .purple
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Setups
    
    
    // MARK:- Overriden methods
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textView.layer.cornerRadius = 24
        textView.layer.borderColor = UIColor.plusContainerBorderGray.cgColor
    }
}
