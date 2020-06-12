//
//  ArrowView.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 31.05.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

final class ArrowView: UIView {
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
        drawArrow()
        UIColor.white.setStroke()
        path.stroke()
    }
    
    func drawArrow() {
        path = UIBezierPath()
        path.move(to: CGPoint(x: self.frame.width/2, y: 0.0))
        path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
        path.move(to: CGPoint(x: self.frame.width/2, y: 0.0))
        path.addLine(to: CGPoint(x: 10.0, y: self.frame.size.height))
        path.lineWidth = 2
    }
}
