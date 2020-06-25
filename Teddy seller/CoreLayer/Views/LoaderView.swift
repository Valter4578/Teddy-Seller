//
//  LoaderView.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 25.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit

class LoaderView: UIView {
    // MARK:- Views
    var acitivityIndicator = UIActivityIndicatorView()
    
    // MARK:- Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .mainBlue 
        setupIndicator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Setups
    private func setupIndicator() {
        
        addSubview(acitivityIndicator)
        
        acitivityIndicator.snp.makeConstraints {
            $0.center.equalTo(self)
        }
    }    
}
