//
//  TopBar.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 08.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit

protocol TopBarDelegate: class {
    func passSelectedIndex(_ index: Int)
}

class TopBar: UIView {
    // MARK:- Properties
    weak var delegate: TopBarDelegate!
    
    var leftButtonText: String?
    var rightButtonText: String?
    
    var selectedButtonIndex: Int? { // 0 - left, 1 - right
        didSet {
            delegate.passSelectedIndex(selectedButtonIndex ?? 1)
        }
    }
     
    // MARK:- Views
    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setTitle(leftButtonText, for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.mainBlue, for: .normal)
        button.addTarget(self, action: #selector(didSelectLeftButton), for: .touchUpInside)
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setTitle(rightButtonText, for: .normal)
        button.backgroundColor = .mainBlue
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didSelectRigthButton), for: .touchUpInside)

        return button
    }()
    
    // MARK:- Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        
        leftButton.addTarget(self, action: #selector(didSelectLeftButton), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(didSelectRigthButton), for: .touchUpInside)

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
        
        leftButton.snp.makeConstraints {
            $0.width.equalTo(130)
            $0.height.equalTo(30)
        }
    }
    
    @objc func didSelectLeftButton() {
        UIView.animate(withDuration: 0.3, animations: {
            self.leftButton.backgroundColor = .mainBlue
            self.leftButton.setTitleColor(.white, for: .normal)
            
            self.rightButton.backgroundColor = .white
            self.rightButton.setTitleColor(.mainBlue, for: .normal)
        }) { _ in
            self.selectedButtonIndex = 0
        }
        
    }
    
    @objc func didSelectRigthButton() {
        UIView.animate(withDuration: 0.3, animations: {
            self.rightButton.backgroundColor = .mainBlue
            self.rightButton.setTitleColor(.white, for: .normal)
            
            self.leftButton.backgroundColor = .white
            self.leftButton.setTitleColor(.mainBlue, for: .normal)
        }) { _ in
            self.selectedButtonIndex = 1
        }
        
    }
}
