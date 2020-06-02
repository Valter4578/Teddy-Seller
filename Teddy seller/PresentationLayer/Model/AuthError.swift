//
//  AuthError.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 02.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Foundation

enum AuthError {
    case phoneEmpty
    case wrongPhone
    case banned
    case databaseConnect
    case sms
}
