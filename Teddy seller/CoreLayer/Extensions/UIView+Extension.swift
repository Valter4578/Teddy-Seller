//
//  UIView+Extension.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 05.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

extension UIView {
    func addGradient(to frame: CGRect) {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.colors = [UIColor.gradientDarkBlue.cgColor, UIColor.gradientLightBlue.cgColor]
        layer.addSublayer(gradient)
    }
}
