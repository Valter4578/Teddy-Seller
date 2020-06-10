//
//  AddAdError.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 10.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Foundation

enum AddAdsError: Error {
    case database
    case tokenOrAdNotSpecified
    case wrongToken 
    case requiredFieldsNotSpecified
    case titleOrPriseIsEmpty
    case wrongCategory
    case wrongFile
}
