//
//  CreateProductCellType.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 09.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Foundation

enum CreateProductCellType {
    case video(title: String, serverName: String)
    case textField(title: String, serverName: String)
    case textView(title: String, serverName: String)
}