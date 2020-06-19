//
//  CreateProductSliderCell.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 19.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit

final class CreateProductSliderCell: UITableViewCell {
    // MARK:- Properties
    var serverName: String?
    
    // MARK:- Views
    let slider: RangeSlider = RangeSlider()
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Heltevica Neue", size: 28)
        label.textAlignment = .left
        label.text = "Lorem ispum"
        return label
    }()
    
    // MARK:- Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSlider()
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Setups
    private func setupLabel() {
        addSubview(label)
        
        label.snp.makeConstraints { maker in
            maker.leading.equalTo(self).offset(20)
            maker.trailing.equalTo(self).offset(-20)
            maker.bottom.equalTo(slider.snp.top)
        }
    }
    
    private func setupSlider() {
        addSubview(slider)
        
        slider.backgroundColor = .purple
        
        slider.snp.makeConstraints {
            $0.leading.equalTo(self).offset(20)
            $0.trailing.equalTo(self).offset(-20)
            $0.height.equalTo(20)
            $0.bottom.equalTo(self).offset(10)
        }
    }
}
