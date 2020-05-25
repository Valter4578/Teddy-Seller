//
//  AuthViewController.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 25.05.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit

class AuthViewController: UIViewController {
    // MARK:- Views
    var teddyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Teddy")
        return imageView
    }()

    var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 16
        textField.backgroundColor = .white
        textField.keyboardType = .numberPad
        
        textField.attributedPlaceholder = NSAttributedString(string: "+7", attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderBlack, NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 24)])
        
        return textField
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.text = "Введите номер телефона"
        label.font = UIFont(name: "Helvetica Neue", size: 24)
        label.textAlignment = .center
        return label
    }()
    
    var nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .authNextBlue
        button.titleLabel?.text = "Далее"
        button.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 36)
        button.titleLabel?.textColor = .authNextGray
        return button
    }()
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .mainBlue
        print(view.frame.height)
        
        
        setupNextButton()
        setupTeddyImageView()
        setupPhoneStackView()
        
    }
    
    // MARK:- Setups
    private func setupNextButton() {
        view.addSubview(nextButton)
        
        nextButton.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(view)
            maker.trailing.equalTo(view)
            maker.leading.equalTo(view)
            maker.height.equalTo(90)
        }
    }
    
    private func setupTeddyImageView() {
        view.addSubview(teddyImageView)
        
        teddyImageView.snp.makeConstraints { (maker) in
            maker.height.equalTo(200)
            maker.width.equalTo(200)
            maker.centerX.equalTo(view)
        }
    }
    
    private func setupPhoneStackView() {
        let stackView = UIStackView(arrangedSubviews: [label, phoneTextField])
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.axis = .vertical
        
        view.addSubview(stackView)

        stackView.snp.makeConstraints { (maker) in
            maker.trailing.equalTo(view).offset(-40)
            maker.leading.equalTo(view).offset(40)
            maker.height.equalTo(98)
            maker.bottom.equalTo(nextButton.snp.top).offset(-150)
            maker.top.equalTo(teddyImageView.snp.bottom).offset(100)
        }
    }
        
    
}

