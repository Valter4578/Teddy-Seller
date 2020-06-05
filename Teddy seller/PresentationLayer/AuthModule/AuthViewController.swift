//
//  AuthViewController.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 25.05.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit
import PhoneNumberKit

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
        textField.keyboardType = .phonePad
        textField.font = UIFont(name: "Helvetica Neue", size: 24)
        textField.textColor = .black
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
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
        phoneTextField.text = ""
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
    
        switch currentState {
        case .phone:
            
            if phoneNumber.count < 12 || phoneNumber.count > 14 {
                let alertBuilder = AuthAlertBuilder(errorType: .wrongPhone)
                alertBuilder.configureAlert { (alertController) in
                    self.present(alertController, animated: true)
                }
                return
            }
            
            teddyService.phoneNumber(phoneNumber: phoneNumber) { (result) in
                switch result {
                case .success(let requestId):
                    print(requestId)
                    self.currentState = .code
                    UserDefaults.standard.set(requestId, forKey: "requestId")
                case .failure(let error):
                    print(error)
                    return
                }
            }
        case .code:
             if phoneNumber.count != 6 {
                let alertBuilder = AuthAlertBuilder(errorType: .wrongPhone)
                alertBuilder.configureAlert { (alertController) in
                    self.present(alertController, animated: true)
                }
                return
            }
            
            guard let requestId = UserDefaults.standard.string(forKey: "requestId") else { return }
            guard let text = phoneTextField.text else { return }
            guard let code = Int(text) else { return }
            teddyService.authorize(requestId: requestId, code: code) { (result) in
                switch result {
                case .success(let token):
                    UserDefaults.standard.set(token, forKey: "token")
                    self.dismiss(animated: true, completion: nil)
                case .failure(let error):
                    print(error)
                    return
                }
            }
        }
    }
    
    // MARK:- Deinit
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
