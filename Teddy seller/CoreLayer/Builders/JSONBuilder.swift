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
        let string = String(data: jsonData, encoding: .utf8)
        print(string)
        return string ?? ""
    }
}
