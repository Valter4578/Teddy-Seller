//
//  RangeSlider.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 15.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

final class RangeSlider: UIControl {
    // MARK:- Overriden properties
    override var frame: CGRect {
        didSet {
            updateLayerFrame()
        }
    }
    
    // MARK:- Properties
    var minimumValue: CGFloat = 0
    var maximumValue: CGFloat = 10
    var lowerValue: CGFloat = 1.6 // user's selected lower value
    var upperValue: CGFloat = 5.6 // user's selected upper value
        
    let circleImage = #imageLiteral(resourceName: "SliderCircle")
    
    // MARK:- Private properties
    private let sliderLayer = CALayer()
    private let lowerDotImageView = UIImageView()
    private let upperDotImageView = UIImageView()
    
    // MARK:- Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        sliderLayer.backgroundColor = UIColor.authNextGray.cgColor
        layer.addSublayer(sliderLayer)
        
        lowerDotImageView.image = circleImage
        upperDotImageView.image = circleImage
        
        addSubview(lowerDotImageView)
        addSubview(upperDotImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Private functions
    private func valuePosition(_ value: CGFloat) -> CGFloat {
        return bounds.width * value
    }
    
    private func dotsOrigin(for value: CGFloat) -> CGPoint {
        let x = valuePosition(value) - circleImage.size.width / 2.0
        return CGPoint(x: x, y: (bounds.height - circleImage.size.height) / 2)
    }
    
    private func updateLayerFrame() {
        sliderLayer.frame = bounds.insetBy(dx: 0.0, dy: bounds.height / 3)
        sliderLayer.setNeedsDisplay()
        lowerDotImageView.frame = CGRect(origin: dotsOrigin(for: lowerValue), size: circleImage.size)
        upperDotImageView.frame = CGRect(origin: dotsOrigin(for: upperValue), size: circleImage.size)
    }
}
