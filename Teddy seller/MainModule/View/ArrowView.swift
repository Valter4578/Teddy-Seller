//
//  ArrowView.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 31.05.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class ArrowView: UIView {
    var path: UIBezierPath!
    
    // MARK:- Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Functions
    override func draw(_ rect: CGRect) {
        drawCanvas1()
    }
    
    func drawCanvas1(frame: CGRect = CGRect(x: 0, y: 0, width: 20, height: 20)) {
            //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 10.5, y: -0.5))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.5, y: frame.minY + 19.5))
        UIColor.white.setStroke()
        bezierPath.lineWidth = 2
        bezierPath.stroke()


        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: 20.5, y: 19.5))
        bezier2Path.addLine(to: CGPoint(x: 10.5, y: -0.5))
        UIColor.white.setStroke()
        bezier2Path.lineWidth = 2
        bezier2Path.stroke()
    }

}
