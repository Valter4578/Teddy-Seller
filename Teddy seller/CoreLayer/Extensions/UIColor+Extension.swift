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
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static func setAsHex (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    // MARK:- Colors
    static var mainBlue: UIColor { // #60BAFF
        return setAsRgb(red: 109, green: 127, blue: 202)
    }
 
    static var placeholderBlack: UIColor { // #383838
        return setAsRgb(red: 56, green: 56, blue: 56)
    }
    
    static var authNextBlue: UIColor { // #34345E
        return setAsRgb(red: 52, green: 52, blue: 94)
    }
    
    static var authNextGray: UIColor { // #D8D8D8
        return setAsHex(hex: "#D8D8D8")
    }
    
    static var borderGray: UIColor { // #A1BDD4
        return setAsRgb(red: 161, green: 189, blue: 212)
    }
    
    static var contactPurple: UIColor { // #591779
        return setAsHex(hex: "#591779")
    }
    
    static var productGray: UIColor { // #2E2E2E
        return setAsRgb(red: 46, green: 46, blue: 46)
    }
    
    static var priceGray: UIColor { // #3A423B
        return setAsRgb(red: 58, green: 66, blue: 59)
    }
    
    static var plusContainerBorderGray: UIColor { // #979797
        return setAsRgb(red: 151, green: 151, blue: 151)
    }
    
    static var gradientDarkBlue: UIColor { // #A1BDD4
        return setAsRgb(red: 55, green: 49, blue: 183)
    }
    
    static var gradientLightBlue: UIColor { // #A1BDD4
        return setAsRgb(red: 146, green: 182, blue: 216)
    }
}

