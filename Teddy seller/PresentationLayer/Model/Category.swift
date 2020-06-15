//
//  Category.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 02.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//
import Foundation

struct Category: Equatable {
    // MARK:- Properties
    let imageName: String?
    let title: String
    let serverName: String? 
    let subcategories: [Category]?
    
    let products: [Product]?
    
    let isParent: Bool?
    
    // MARK:- Functions
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.title == rhs.title
    }
    
    // MARK:- Inits
    init(imageName: String? = nil, title: String, serverName: String? = nil, isParent: Bool = false, products: [Product]? = nil, subcategories: [Category]? = nil) {
        self.imageName = imageName
        self.title = title
        self.products = products
        self.subcategories = subcategories
        self.serverName = serverName
        self.isParent = isParent
    }
}
