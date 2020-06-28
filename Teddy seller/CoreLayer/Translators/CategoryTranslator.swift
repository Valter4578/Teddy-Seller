//
//  CategoryTranslator.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 26.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Foundation

class CategoryTranslator {
    static func getCorrectName(for title: String) -> String?  {
        switch title {
        case "квартиры":
            return "квартиру"
        case "дома":
            return "дом"
        case "легковые":
            return "легковое"
        case "спецтехника":
            return "спецтехнику"
        case "мотоциклы":
            return "мотоцикл"
        default:
            return nil
        }
    }
}
