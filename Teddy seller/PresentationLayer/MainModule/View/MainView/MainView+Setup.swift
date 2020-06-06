//
//  MainView+Setup.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 02.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import SnapKit

extension MainViewConllectionViewCell {
    func setupImageView() {
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (maker) in
            maker.centerY.equalTo(self).offset(-10)
            maker.centerX.equalTo(self)
            maker.height.equalTo(80)
            maker.width.equalTo(80)
        }
    }
    
    func setupLabel() {
        addSubview(textLabel)
        textLabel.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(self)
            maker.top.equalTo(iconImageView.snp.bottom).offset(10)
        }
    }
}
