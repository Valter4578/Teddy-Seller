//
//  BottomBar.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 04.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit

class BottomBar: UIView {
    // MARK:- Views
    let plusContainer: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.backgroundColor = .authNextGray
        button.layer.borderColor = UIColor.plusContainerBorderGray.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    let verticalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let horizontalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    // MARK:- Setups
    private func setupPlusContainer() {
        addSubview(plusContainer)
        
        plusContainer.snp.makeConstraints {
            $0.center.equalTo(self)
            $0.width.equalTo(60)
            $0.height.equalTo(60)
        }
    }
    
    private func setupPlusLines() {
        addSubview(verticalLineView)
        
        verticalLineView.snp.makeConstraints {
            $0.center.equalTo(plusContainer.snp.center)
            $0.height.equalTo(30)
            $0.width.equalTo(1)
        }
        
        addSubview(horizontalLineView)
        
        horizontalLineView.snp.makeConstraints {
            $0.center.equalTo(plusContainer.snp.center)
            $0.height.equalTo(1)
            $0.width.equalTo(30)
        }
    }
    
    // MARK:- Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        
        setupPlusContainer()
        setupPlusLines()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Overriden methods
    override func layoutSubviews() {
        super.layoutSubviews()
        
        plusContainer.layer.borderColor = UIColor.plusContainerBorderGray.cgColor
        plusContainer.layer.borderWidth = 1
        plusContainer.layer.cornerRadius = plusContainer.bounds.width/2
    }
}
