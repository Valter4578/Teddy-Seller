//
//  AuthViewController.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 25.05.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit

final class AuthViewController: UIViewController {
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
        textField.font = UIFont(name: "Helvetica Neue", size: 24)
        
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
        button.setTitle("Далее", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 36)
        button.titleLabel?.textColor = .authNextGray
        return button
    }()
    
    var stackView: UIStackView!
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .mainBlue
        print(view.frame.height)
        
        setupNotificationCenter()

        setupNextButton()
        setupTeddyImageView()
        setupPhoneStackView()
        
        hideKeyboardByTapAround()
    }
    
    // MARK:- Private functions
    private func hideKeyboardByTapAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapAround))
        view.addGestureRecognizer(tap)
    }
    
    // MARK:- Selectors
    @objc func keyboardWillShow(sender: Notification) {
        if let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame.origin.y = -keyboardHeight
            self.teddyImageView.alpha = 0
        }
    }
    
    @objc func keyboardWillHide(sender: Notification) {
        self.view.frame.origin.y = 0 // Move view to original position
        self.teddyImageView.alpha = 1
    }
    
    @objc func didTapAround() {
        view.endEditing(true)
    }
    
    // MARK:- Setups
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
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
            maker.top.equalTo(view).offset(20).priority(.high)
        }
    }
    
    private func setupPhoneStackView() {
        stackView = UIStackView(arrangedSubviews: [label, phoneTextField])
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
    
    // MARK:- Deinit
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
