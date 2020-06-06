//
//  Auth+setups.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 02.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

extension AuthViewController {
    func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setupNextButton() {
        view.addSubview(nextButton)
        
        nextButton.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(view)
            maker.trailing.equalTo(view)
            maker.leading.equalTo(view)
            maker.height.equalTo(90)
        }
    }
    
    func setupTeddyImageView() {
        view.addSubview(teddyImageView)
        
        teddyImageView.snp.makeConstraints { (maker) in
            maker.height.equalTo(200)
            maker.width.equalTo(200)
            maker.centerX.equalTo(view)
            maker.top.equalTo(view).offset(60)
        }
    }
    
    func setupPhoneStackView() {
        stackView = UIStackView(arrangedSubviews: [label, phoneTextField])
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.axis = .vertical
        
        view.addSubview(stackView)

        stackView.snp.makeConstraints { (maker) in
            maker.trailing.equalTo(view).offset(-40)
            maker.leading.equalTo(view).offset(40)
            maker.height.equalTo(98)
            maker.top.equalTo(teddyImageView.snp.bottom).offset(100)
        }
    }
}
