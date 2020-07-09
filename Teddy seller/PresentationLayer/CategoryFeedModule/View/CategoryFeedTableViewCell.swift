//
//  CategoryFeedTableViewCell.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 30.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation

final class CategoryFeedTableViewCell: UITableViewCell {
    // MARK:- Views
    let productItem = ProductItem()
    
    // MARK:- Properties
    
    /// boolean flag that indicates if video loaded 
    var isVideoLoaded: Bool = false
    
    // MARK:- Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print(#function)
        
        backgroundColor = .mainBlue
        
        if productItem.videoContrainer.player == nil {
            productItem.videoContrainer.player = AVPlayer()
        }
        
        setupProductItem(width: UIScreen.main.bounds.width)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Functions
    func configureCell(shouldPlay: Bool) {
        if let stringUrl = productItem.product?.dictionary["video"] as? String, let videoUrl = URL(string: stringUrl) {
            productItem.videoContrainer.setPlayerItem(url: videoUrl)
        }
        
        if shouldPlay {
            productItem.videoContrainer.playPlayer()
        } else {
            if productItem.videoContrainer.player != nil {
                productItem.videoContrainer.pausePlayer()
                productItem.videoContrainer.player = nil
            }
        }
    }
    
    // MARK:- Overriden methods
    override func prepareForReuse() {
        self.productItem.videoContrainer.pausePlayer()
//        self.productItem.videoContrainer.player = nil
    }
    
    // MARK:- Setups
    private func setupProductItem(width: CGFloat) {
        addSubview(productItem)
        
        productItem.snp.makeConstraints { maker in
            maker.width.equalTo(width - 20)
            maker.height.equalTo(250)
            maker.center.equalTo(self)
        }
    }
    
    // MARK:- Lifecycle
    override func layoutSubviews() {
        productItem.layer.cornerRadius = 12
    }
}
