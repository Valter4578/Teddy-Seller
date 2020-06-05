//
//  AuthError.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 02.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Foundation

enum AuthError: Error {
    case phoneEmpty
    case wrongPhone
    case banned
    case databaseConnect
    case sms
    
    case codeEmpty
    case wrongCode
    case requestExpired
}
