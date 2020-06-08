//
//  TopBar.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 08.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit

class TopBar: UIView {
    // MARK:-
    var leftButtonText: String?
    var rightButtonText: String?
    
    // MARK:- Views
    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setTitle(leftButtonText, for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.mainBlue, for: .normal)
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setTitle(rightButtonText, for: .normal)
        button.backgroundColor = .mainBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    // MARK:- Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        
        setupStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Setups
    func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [leftButton, rightButton])
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.center.equalTo(self)
        }
    }
}
