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
        print(#function + "width - \(frame.width) height - \(frame.height)")
        iconImageView.snp.makeConstraints { (maker) in
            maker.centerY.equalTo(self).offset(-5)
            maker.centerX.equalTo(self)
            maker.height.equalTo(90)
            maker.width.equalTo(90)
        }
    }
    
    func setupLabel() {
        addSubview(textLabel)
        print(#function + "width - \(frame.width) height - \(frame.height)")
        textLabel.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(self)
            maker.top.equalTo(iconImageView.snp.bottom).offset(5)
        }
    }
}
