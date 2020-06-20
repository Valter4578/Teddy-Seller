//
//  CellType.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 09.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import CoreGraphics
import Foundation

enum CellType: Equatable {
    case video(title: String, serverName: String)
    case textField(title: String, serverName: String, needsOnlyNumbers: Bool)
    case textView(title: String, serverName: String)
    case slider(title: String, serverName: String, minimumValue: CGFloat, maximumValue: CGFloat)
}
