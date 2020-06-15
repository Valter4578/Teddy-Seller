//
//  ProductDetailViewController.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 07.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

final class ProductDetailViewController: UIViewController {
    // MARK:- Views
    let contactButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .contactPurple
        button.setTitle("Cвязаться", for: .normal)
        button.titleLabel?.font = UIFont(name: "Heltevica Neue", size: 28)
        button.addTarget(self, action: #selector(didTapContactButton), for: .touchUpInside)
        return button
    }()
    
    let videoContainer: PlayerView = PlayerView() 
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.font = UIFont(name: "Helvetica Neue", size: 24)
        return textView
    }()
    
    var arrowView: ArrowView = {
        let view = ArrowView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        view.transform = CGAffineTransform(rotationAngle: -(.pi/2))
        return view
    }()
    
    // MARK:- Propeties
    var product: Product? {
        didSet {
            configureScreen()
        }
    }
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupGestureRecognizer()
        setupVideoContainer()
        setupContactButton()
        setupTextView()
        setupNavigationBar()
        
        configureScreen()
    }
    
    // MARK:- Private methods
    private func configureScreen() {
        configurePlayer()
        
        let textViewAttributedString = NSMutableAttributedString()
        product?.dictionary.forEach({ key, value in
            guard let valueString = value as? String else { return }
            
            if valueString == "subcategory" { return }
            if valueString == "id" { return }
            
            guard let keyName = DictionaryTranslator.getName(from: key) else { return }
            
            textViewAttributedString.append(NSAttributedString(string: keyName + ": ", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 20)]))
            textViewAttributedString.append(NSAttributedString(string: valueString + "\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]))
        })
        
        descriptionTextView.attributedText = textViewAttributedString
    }
    
    private func configurePlayer() {
        guard let stringUrl = product?.dictionary["video"] as? String,
            let videoUrl = URL(string: stringUrl) else { return }
        videoContainer.setPlayerURL(url: videoUrl)
        videoContainer.player.play()
    }
    
    // MARK:- Selectors
    @objc func dissmisProduct() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapContactButton() {
        guard let phoneNumber = product?.phoneNumber,
            let url = URL(string: "tel://\(phoneNumber)") else { return }
        UIApplication.shared.open(url)
    }
}
