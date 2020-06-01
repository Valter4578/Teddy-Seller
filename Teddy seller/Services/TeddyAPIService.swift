//
//  TeddyAPIService.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 01.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class TeddyAPIService {
    // MARK:- Functions
    func phoneNumber(phoneNumber: String, completionHandler: @escaping (Int) -> Void) {
        let parametrs: [String: String] = [
            "number": phoneNumber
        ]
        
        AF.request("http://194.9.71.20/phoneNumber", method: .post, parameters: parametrs)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    guard let string = value as? Data,
                          let json = try? JSON(data: string) else { return }
                    let requestId = json["request_id"].intValue
                    completionHandler(requestId)
                case .failure(let error):
                    print(error)
                }
        }
    }
}
