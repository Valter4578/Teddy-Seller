//
//  RangeSlider.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 19.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

//final class RangeSlider: UIControl {
//    // MARK:- Overriden properties
//    override var frame: CGRect {
//        didSet {
//            updateLayerFrame()
//        }
//    }
//
//    // MARK:- Properties
//    var minimumValue: CGFloat = 0
//    var maximumValue: CGFloat = 10
//    var lowerValue: CGFloat = 1.6 // user's selected lower value
//    var upperValue: CGFloat = 5.6 // user's selected upper value
//
//    let circleImage = #imageLiteral(resourceName: "SliderCircle")
//
//    // MARK:- Private properties
//    private let sliderLayer = CALayer()
//    private let lowerDotImageView = UIImageView()
//    private let upperDotImageView = UIImageView()
//
//    // MARK:- Inits
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        sliderLayer.backgroundColor = UIColor.authNextGray.cgColor
//        layer.addSublayer(sliderLayer)
//
//        lowerDotImageView.image = circleImage
//        upperDotImageView.image = circleImage
//
//        addSubview(lowerDotImageView)
//        addSubview(upperDotImageView)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // MARK:- Private functions
//    private func valuePosition(_ value: CGFloat) -> CGFloat {
//        return bounds.width * value
//    }
//
//    private func dotsOrigin(for value: CGFloat) -> CGPoint {
//        let x = valuePosition(value) - circleImage.size.width / 2.0
//        return CGPoint(x: x, y: (bounds.height - circleImage.size.height) / 2)
//    }
//
//    private func updateLayerFrame() {
//        sliderLayer.frame = bounds.insetBy(dx: 0.0, dy: bounds.height / 3)
//        sliderLayer.setNeedsDisplay()
//        lowerDotImageView.frame = CGRect(origin: dotsOrigin(for: lowerValue), size: circleImage.size)
//        upperDotImageView.frame = CGRect(origin: dotsOrigin(for: upperValue), size: circleImage.size)
//    }
//}


class RangeSlider: UIControl {
    
    // MARK:- Overriden properties
    override var frame: CGRect {
        didSet {
            updateLayerFrames()
        }
    }
    
    // MARK:- Properties
    var minimumValue: CGFloat = 0 {
        didSet {
            updateLayerFrames()
        }
    }
    
    var maximumValue: CGFloat = 1 {
        didSet {
            updateLayerFrames()
        }
    }
    
    var lowerValue: CGFloat = 0.2 {
        didSet {
            updateLayerFrames()
        }
    }
    
    var upperValue: CGFloat = 0.8 {
        didSet {
            updateLayerFrames()
        }
    }
    
    var trackTintColor = UIColor(white: 0.9, alpha: 1) {
        didSet {
            trackLayer.setNeedsDisplay()
        }
    }
    
    var trackHighlightTintColor = UIColor(red: 0, green: 0.45, blue: 0.94, alpha: 1) {
        didSet {
            trackLayer.setNeedsDisplay()
        }
    }
    
    var thumbImage = #imageLiteral(resourceName: "SliderCircle") {
        didSet {
            upperThumbImageView.image = thumbImage
            lowerThumbImageView.image = thumbImage
            updateLayerFrames()
        }
    }
    
    var highlightedThumbImage = #imageLiteral(resourceName: "SliderCircle") {
        didSet {
            upperThumbImageView.highlightedImage = highlightedThumbImage
            lowerThumbImageView.highlightedImage = highlightedThumbImage
            updateLayerFrames()
        }
    }
    
    // MARK:- Private properties
    private let trackLayer = RangeSliderTrackLayer()
    private let lowerThumbImageView = UIImageView()
    private let upperThumbImageView = UIImageView()
    private var previousLocation = CGPoint()
    
    // MARK:- Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        trackLayer.rangeSlider = self
        trackLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(trackLayer)
        
        lowerThumbImageView.image = thumbImage
        addSubview(lowerThumbImageView)
        
        upperThumbImageView.image = thumbImage
        addSubview(upperThumbImageView)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Functions
    func positionForValue(_ value: CGFloat) -> CGFloat {
        return bounds.width * value
    }
    
    // MARK:- Private functions
    private func updateLayerFrames() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        trackLayer.frame = bounds.insetBy(dx: 0.0, dy: bounds.height / 3)
        trackLayer.setNeedsDisplay()
        lowerThumbImageView.frame = CGRect(origin: thumbOriginForValue(lowerValue),
                                           size: thumbImage.size)
        upperThumbImageView.frame = CGRect(origin: thumbOriginForValue(upperValue),
                                           size: thumbImage.size)
        CATransaction.commit()
    }
    
    private func thumbOriginForValue(_ value: CGFloat) -> CGPoint {
        let x = positionForValue(value) - thumbImage.size.width / 2.0
        return CGPoint(x: x, y: (bounds.height - thumbImage.size.height) / 2.0)
    }
}

extension RangeSlider {
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        previousLocation = touch.location(in: self)
        
        if lowerThumbImageView.frame.contains(previousLocation) {
            lowerThumbImageView.isHighlighted = true
        } else if upperThumbImageView.frame.contains(previousLocation) {
            upperThumbImageView.isHighlighted = true
        }
        
        return lowerThumbImageView.isHighlighted || upperThumbImageView.isHighlighted
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        
        let deltaLocation = location.x - previousLocation.x
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / bounds.width
        
        previousLocation = location
        
        if lowerThumbImageView.isHighlighted {
            lowerValue += deltaValue
            lowerValue = boundValue(lowerValue, toLowerValue: minimumValue,
                                    upperValue: upperValue)
        } else if upperThumbImageView.isHighlighted {
            upperValue += deltaValue
            upperValue = boundValue(upperValue, toLowerValue: lowerValue,
                                    upperValue: maximumValue)
        }
        
        sendActions(for: .valueChanged)
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        lowerThumbImageView.isHighlighted = false
        upperThumbImageView.isHighlighted = false
    }
    
    private func boundValue(_ value: CGFloat, toLowerValue lowerValue: CGFloat, upperValue: CGFloat) -> CGFloat {
        return min(max(value, lowerValue), upperValue)
    }
}
