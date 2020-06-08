//
//  Category.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 02.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//
import Foundation

struct Category {
    let imageName: String?
    let title: String
    let serverName: String? 
    let subcategories: [Category]?
    
    let products: [Product]?
    
    init(imageName: String? = nil, title: String, serverName: String? = nil, products: [Product]? = nil, subcategories: [Category]? = nil) {
        self.imageName = imageName
        self.title = title
        self.products = products
        self.subcategories = subcategories
        self.serverName = serverName
    }
}
