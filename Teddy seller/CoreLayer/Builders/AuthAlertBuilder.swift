//
//  AuthAlertBuilder.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 02.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class AuthAlertBuilder {
    // MARK:- Properties
    var errorType: AuthError?
    var alertController: UIAlertController?
    
    // MARK: - Functions
    func configureAlert(completionHandler: @escaping (UIAlertController) -> Void) {
        let defualtAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        switch errorType {
        case .phoneEmpty:
            alertController = UIAlertController(title: "Номер телефона пуст", message: "Введите номер телефона", preferredStyle: .alert)
        case .wrongPhone:
            alertController = UIAlertController(title: "Неправильный формат номера телефона", message: "Введите правильный номер телефона", preferredStyle: .alert)
        case .banned:
            alertController = UIAlertController(title: "Пользователь заблокирован", message: nil, preferredStyle: .alert)
        case .databaseConnect:
            alertController = UIAlertController(title: "Ошибка сервера", message: "Попробуйте еще раз", preferredStyle: .alert)
        case .sms:
            alertController = UIAlertController(title: "Ошибка отправки SMS", message: "Попробуйте еще раз", preferredStyle: .alert)
        case .none:
            break
        }
        
        guard let alert = alertController else { return }
        alert.addAction(defualtAction)
        completionHandler(alert)
    }
    
    // MARK:- Initializer
    init(errorType: AuthError) {
        self.errorType = errorType
    }
    
}
