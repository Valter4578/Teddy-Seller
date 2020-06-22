//
//  UploadError.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 22.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Foundation

enum UploadError: Error {
    case database
    case dataIsntSpecified
    case wrongToken
    case wrongId
    case wrongFile
    case dbQuery 
}
 

