//
//  AddAdAlertBuilder.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 10.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class AddAdAlertBuilder {
    // MARK:- Properties
    var errorType: AddAdsError?
    var alertController: UIAlertController?
    
    // MARK: - Functions
    func configureAlert(completionHandler: @escaping (UIAlertController) -> Void) {
        let defualtAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        switch errorType {
        case .database:
            alertController = UIAlertController(title: "Ошибка на сервере", message: "Попробуйте позже", preferredStyle: .alert)
        case .requiredFieldsNotSpecified:
            alertController = UIAlertController(title: "Обязательные поля не введены", message: "Введите все данные", preferredStyle: .alert)
        case .titleOrPriseIsEmpty:
            alertController = UIAlertController(title: "Название или цена не введены", message: "Введите все данные", preferredStyle: .alert)
        case .tokenOrAdNotSpecified:
            alertController = UIAlertController(title: "Что-то пошло не так", message: "Попробуйте позже", preferredStyle: .alert)
        case .wrongCategory:
            alertController = UIAlertController(title: "Что-то пошло не так", message: "Попробуйте позже", preferredStyle: .alert)
        case .wrongFile:
            alertController = UIAlertController(title: "Что-то пошло не так", message: "Попробуйте позже", preferredStyle: .alert)
        default:
            return
        }
        
        guard let alert = alertController else { return }
        alert.addAction(defualtAction)
        completionHandler(alert)
    }
    
    // MARK:- Initializer
    init(errorType: AddAdsError) {
        self.errorType = errorType
    }
}
