//
//  AdsError.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 06.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Foundation

enum AdsError: Error {
    case database
    case dataNotSpecified
    case wrongToken
    case wrongSubcategory
}
