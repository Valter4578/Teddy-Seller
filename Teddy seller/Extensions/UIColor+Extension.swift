//
//  UIColor+Extension.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 24.05.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

extension UIColor {
    // MARK:- Methods
    static func setAsRgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/225, blue: blue/255, alpha: 1)
    }
    
    // MARK:- Colors
    static var mainBlue: UIColor {
        return setAsRgb(red: 96, green: 186, blue: 255)
    }
 
}
