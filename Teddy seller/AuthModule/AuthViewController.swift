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
        
        setupNextButton()
        setupTeddyImageView()
        setupLabel()
        setupTextField()
    }
    
    // MARK:- Setups
    private func setupNextButton() {
        view.addSubview(nextButton)
        
        nextButton.snp.makeConstraints { (maker) in
        }
    }
    
    private func setupTeddyImageView() {
        view.addSubview(teddyImageView)
        
        teddyImageView.snp.makeConstraints { (maker) in

        }
    }
    
    private func setupLabel() {
        view.addSubview(label)
        
        label.snp.makeConstraints { (maker) in
        }
    }
    
    private func setupTextField() {
        view.addSubview(phoneTextField)
        
        phoneTextField.snp.makeConstraints { (maker) in
        }
    }
}

