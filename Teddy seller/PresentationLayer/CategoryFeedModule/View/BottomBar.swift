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
    let plusContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .authNextGray
        view.layer.cornerRadius = view.bounds.width/2
        view.layer.borderColor = UIColor.plusContainerBorderGray.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    
    // MARK:- Setups
    private func setupPlusContainer() {
        addSubview(plusContainer)
        
        plusContainer.layer.borderColor = UIColor.plusContainerBorderGray.cgColor
        plusContainer.layer.borderWidth = 1
        plusContainer.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.centerY.equalTo(self)
            $0.width.equalTo(60)
            $0.height.equalTo(60)
        }
    }
    
    // MARK:- Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        
        setupPlusContainer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
