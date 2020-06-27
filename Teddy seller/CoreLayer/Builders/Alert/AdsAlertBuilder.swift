//
//  AdsAlertBuilder.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 06.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class AdsAlertBuilder {
    // MARK:- Properties
    var errorType: AdsError?
    var alertController: UIAlertController?
    
    // MARK: - Functions
    func configureAlert(completionHandler: @escaping (UIAlertController) -> Void) {
        let defualtAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        switch errorType {
        case .database:
            alertController = UIAlertController(title: "Ошибка на стороне сервера", message: "Попробуйте еще раз", preferredStyle: .alert)
            
        case .dataNotSpecified:
            alertController = UIAlertController(title: "Ошибка в приложении", message: "Попробуйте еще раз", preferredStyle: .alert)
            
        case .wrongSubcategory:
            alertController = UIAlertController(title: "Ошибка в приложении", message: "Попробуйте еще раз", preferredStyle: .alert)
            
        case .wrongToken:
            alertController = UIAlertController(title: "Срок авторизации истек", message: "Попробуйте еще раз", preferredStyle: .alert)
        case .none:
            break
        }
        
        guard let alert = alertController else { return }
        alert.addAction(defualtAction)
        completionHandler(alert)
    }
    
    // MARK:- Initializer
    init(errorType: AdsError) {
        self.errorType = errorType
    }
}

