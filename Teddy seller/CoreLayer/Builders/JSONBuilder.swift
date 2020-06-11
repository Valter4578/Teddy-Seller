//
//  JSONBuilder.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 10.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Foundation

class JSONBuilder {
    static func createJSON(parametrs: [String: Any]) -> String {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parametrs) else { return "" }
        guard let string = String(data: jsonData, encoding: .utf8) else { return "" }
        print(string)
        return string
    }
    
    static func createDictionary(data: Data) -> [String: Any]? {
        return try? JSONSerialization.jsonObject(with: data) as? [String: Any]
    }
    
}
