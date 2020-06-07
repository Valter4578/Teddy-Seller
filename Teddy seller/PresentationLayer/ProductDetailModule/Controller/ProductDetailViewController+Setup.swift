//
//  ProductDetailViewController+Setup.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 07.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import SnapKit

extension ProductDetailViewController {
    func setupContactButton() {
        view.addSubview(contactButton)
        
        contactButton.snp.makeConstraints {
            $0.leading.equalTo(view)
            $0.trailing.equalTo(view)
            $0.bottom.equalTo(view)
            $0.height.equalTo(78)
        }
    }
    
    func setupVideoContainer() {
        view.addSubview(videoContainer)
        
        videoContainer.snp.makeConstraints {
            $0.leading.equalTo(view)
            $0.trailing.equalTo(view)
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
