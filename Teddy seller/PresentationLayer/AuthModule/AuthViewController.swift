//
//  AuthViewController.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 25.05.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit

enum AuthState {
    case phone
    case code
}

final class AuthViewController: UIViewController {
    // MARK:- Properties
    var currentState: AuthState = .phone {
        didSet {
            didChangeState()
        }
    }
    
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
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    var stackView: UIStackView!
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .mainBlue
        
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
    
    private func didChangeState() {
        switch currentState {
        case .phone:
            label.text = "Введите номер телефона"
        case .code:
            label.text = "Введите код"
        }
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
    
    @objc func didTapButton() {
        print(#function)
        guard let phoneNumber = phoneTextField.text else { return }
        
        if phoneNumber.isEmpty {
            let alertBuilder = AuthAlertBuilder(errorType: .phoneEmpty)
            alertBuilder.configureAlert { (alertController) in
                self.present(alertController, animated: true)
            }
            return
        }
        
        let teddyService = TeddyAPIService()
        if currentState == .phone {
            teddyService.phoneNumber(phoneNumber: phoneNumber) { (requestId) in
                print(requestId)
            }
        
            currentState = .code
        }
    }
    
    // MARK:- Deinit
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
