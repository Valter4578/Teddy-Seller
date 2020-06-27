//
//  AlertBuilder.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 26.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class AlertBuilder {
    static func createAlert(message: String, title: String = "Ошибка", for viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(action)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
}
