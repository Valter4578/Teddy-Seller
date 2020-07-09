//
//  Product.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 03.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Foundation

struct Product {
    // MARK:- Properties
    let title: String
    let price: Int
    let phoneNumber: Int 
    let category: Category
    /// JSON dictionary
    let dictionary: [String: Any]
}
