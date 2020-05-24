//
//  UIColor+Extension.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 24.05.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

extension UIColor {
    static func setAsRgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/225, blue: blue/255, alpha: 1)
    }
    
    static var mainBlue: UIColor {
        return setAsRgb(red: 37, green: 67, blue: 98)
    }
}
