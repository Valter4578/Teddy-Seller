//
//  VideoPlusView.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 13.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit

class VideoPlusView: UIView {
    // MARK:- Views
    let verticalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    let horizontalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    // MARK:- Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray
        
        setupPlus()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Setups
    private func setupPlus() {
        addSubview(horizontalLineView)
        
        horizontalLineView.snp.makeConstraints { maker in
            maker.center.equalTo(self)
            maker.height.equalTo(10)
            maker.width.equalTo(60)
        }
        
        addSubview(verticalLineView)
                
        verticalLineView.snp.makeConstraints { maker in
            maker.center.equalTo(self)
            maker.height.equalTo(60)
            maker.width.equalTo(10)
        }
    }
}
