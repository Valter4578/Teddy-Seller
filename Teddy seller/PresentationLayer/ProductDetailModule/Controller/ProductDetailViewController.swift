//
//  ProductDetailViewController.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 07.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    // MARK:- Views
    let contactButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .contactPurple
        button.setTitle("Cвязаться", for: .normal)
        button.titleLabel?.font = UIFont(name: "Heltevica Neue", size: 28)
        return button
    }()
    
    let videoContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        // test data 
        textView.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ex soleat habemus usu, te nec eligendi deserunt vituperata. Nam tempor utamur gubergren no. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Dolorem sit amet, consectetur adipiscing elit, sed do eiusmod tempor. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ex soleat habemus usu, te nec eligendi deserunt vituperata. Nam tempor utamur gubergren no. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Dolorem sit amet, consectetur adipiscing elit, sed do eiusmod tempor. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ex soleat habemus usu, te nec eligendi deserunt vituperata. Nam tempor utamur gubergren no. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Dolorem sit amet, consectetur adipiscing elit, sed do eiusmod tempor."
        textView.font = UIFont(name: "Heltevica Neue", size: 24)
        return textView
    }()
    
    var arrowView: ArrowView = {
        let view = ArrowView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        view.transform = CGAffineTransform(rotationAngle: -(.pi/2))
        return view
    }()
    
    // MARK:- Propeties
    var product: Product?
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupGestureRecognizer()
        setupVideoContainer()
        setupContactButton()
        setupTextView()
        setupNavigationBar()
        
    }
    
    // MARK:- Selectors
    @objc func dissmisProduct() {
        navigationController?.popViewController(animated: true)
    }
}
