//
//  CreateProductVideoTableViewCell.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 09.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class CreateProductVideoTableViewCell: UITableViewCell {
    // MARK:- Views
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Heltevica Neue", size: 24)
        label.textAlignment = .left
        label.text = "Lorem ispum"
        return label
    }()
    
    let videoContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    // MARK:- Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupVideoContainer()
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Setups
    private func setupVideoContainer() {
        addSubview(videoContainer)
        
        videoContainer.snp.makeConstraints { maker in
            maker.height.equalTo(185)
            maker.leading.equalTo(self).offset(20)
            maker.trailing.equalTo(self).offset(-20)
            maker.bottom.equalTo(self).offset(-5)
        }
    }
    
    private func setupLabel() {
        addSubview(label)
        
        label.snp.makeConstraints { maker in
            maker.leading.equalTo(self).offset(20)
            maker.trailing.equalTo(self).offset(-20)
            maker.bottom.equalTo(videoContainer.snp.top).offset(-10)
        }
    }
}
