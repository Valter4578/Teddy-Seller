//
//  DictionaryTranslator.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 12.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Foundation

class DictionaryTranslator {
    /// Function to translate server name to russian
    /// - Parameter serverName: json key
    /// - Returns: russian key
    static func getName(from serverName: String) -> String? {
        switch serverName {
        case "square":
            return "Адрес"
        case "floors":
            return "Количество этажей"
        case "year":
            return "Год"
        case "material":
            return "Материал стен"
        case "rooms":
            return "Количество комнат"
        case "mark":
            return "Марка"
        case "model":
            return "Модель"
        case "mileage":
            return "Пробег"
        case "schedule":
            return "График"
        case "expierenceYears":
            return "Опыт работы"
        case "price":
            return "Цена"
        case "description":
            return ""
        default:
            return nil
        }
    }
}
