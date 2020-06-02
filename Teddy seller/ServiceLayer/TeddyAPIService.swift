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
    // MARK:- Constants
    let url = "http://194.9.71.20"
    
    // MARK:- Functions
    func phoneNumber(phoneNumber: String, completionHandler: @escaping (Result<String, AuthError>) -> Void) {
        let trimmedString = phoneNumber.filter("0123456789".contains)
        
        let parametrs: [String: String] = [
            "number": trimmedString
        ]
        
        AF.request("\(url)/phoneNumber", method: .post, parameters: parametrs)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    print(value)
                    let json = JSON(arrayLiteral: value)
                    print(json)

                    let requestId = json[0]["request_id"].stringValue
    
                    completionHandler(.success(requestId))
                case .failure(let error):
                    print(error)
                    return
                }
        }
    }
    
    func authorize(requestId: String, code: Int,completionHandler: @escaping (Result<String, Error>) -> Void) {
        let parametrs: [String: Any] = [
            "request_id": requestId,
            "code": code
        ]
        
        AF.request("\(url)/authorize", method: .post, parameters: parametrs)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(arrayLiteral: value)
                    let token = json[0]["token"].stringValue
                    completionHandler(.success(token))
                case .failure(let error):
                    print(error)
                    completionHandler(.failure(error))
                }
        }
    }
}