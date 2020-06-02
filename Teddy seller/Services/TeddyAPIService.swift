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
    func phoneNumber(phoneNumber: String, completionHandler: @escaping (Result<Int, Error>) -> Void) {
        let parametrs: [String: String] = [
            "number": phoneNumber
        ]
        
        AF.request("\(url)/phoneNumber", method: .post, parameters: parametrs)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    guard let string = value as? Data,
                          let json = try? JSON(data: string) else { return }
                    let requestId = json["request_id"].intValue
                    completionHandler(.success(requestId))
                case .failure(let error):
                    completionHandler(.failure(error))
                }
        }
    }
    
    func authorize(requestId: Int, code: Int,completionHandler: @escaping (Result<String, Error>) -> Void) {
        let parametrs: [String: Any] = [
            "request_id": requestId,
            "code": code
        ]
        
        AF.request("\(url)/authorize", method: .post, parameters: parametrs)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    guard let string = value as? Data,
                          let json = try? JSON(data: string) else { return }
                    
                    let token = json["token"].stringValue
                    completionHandler(.success(token))
                case .failure(let error):
                    print(error)
                    completionHandler(.failure(error))
                }
        }
    }
}
