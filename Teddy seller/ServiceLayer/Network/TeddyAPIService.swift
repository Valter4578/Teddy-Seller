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

                    let error = json[0]["error"].stringValue
                    switch error {
                    case "Can not connect to database":
                        completionHandler(.failure(.databaseConnect))
                    case "Phone number is not specified":
                        completionHandler(.failure(.phoneEmpty))
                    case "Wrong phone number":
                        completionHandler(.failure(.wrongPhone))
                    case "SMS error":
                        completionHandler(.failure(.sms))
                    case "User is banned":
                        completionHandler(.failure(.banned))
                    default:
                        let requestId = json[0]["request_id"].stringValue
                        completionHandler(.success(requestId))
                    }
                case .failure(let error):
                    print(error)
                    return
                }
        }
    }
    
    func authorize(requestId: String, code: Int,completionHandler: @escaping (Result<String, AuthError>) -> Void) {
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
                    
                    let error = json[0]["error"]
                    switch error {
                    case "Can not connect to database":
                        completionHandler(.failure(.databaseConnect))
                    case "Request ID or Code is not specified":
                        completionHandler(.failure(.codeEmpty))
                    case "Wrong Request ID or Code":
                        completionHandler(.failure(.wrongCode))
                    case "Request ID expired":
                        completionHandler(.failure(.requestExpired))
                    default:
                        let token = json[0]["token"].stringValue
                        print(token)
                        completionHandler(.success(token))
                    }
                    
                case .failure(let error):
                    print(error)
                    return
                }
        }
    }
    
    func getAds(for subcategory: Category, searchJson: String, completionHandler: @escaping (Result<Product, AdsError>) -> ()) {
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        
        guard let serverName = subcategory.serverName else { return }
        let parametrs: [String: String] = [
            "token": token,
            "subcategory": serverName,
            "search": searchJson
        ]
        
        AF.request("\(url)/getAdsForSubcategory", method: .get, parameters: parametrs)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json =  JSON(arrayLiteral: value)
                    print(json)
                    
                    let error = json[0]["error"].stringValue
                    switch error {
                    case "Can not connect to database":
                        completionHandler(.failure(.database))
                    case "Token or subcategory is not specified":
                        completionHandler(.failure(.dataNotSpecified))
                    case "Wrong token":
                        completionHandler(.failure(.wrongToken))
                    case "Wrong subcategory":
                        completionHandler(.failure(.wrongSubcategory))
                    default:
                        let allElements = json[0].arrayValue
                        
                        if allElements.count != 0 {                        
                            for i in 0...allElements.count - 1 {
                                let title = json[0][i]["title"].stringValue
                                let price = json[0][i]["price"].intValue
                                let phoneNumber = json[0][i]["author"]["username"].intValue
                                let category = json[0][i]["subcategory"].stringValue
                                
                                guard let products = value as? [Any] else { return }
                                if let productDictionary = products[i] as? [String: Any] {
                                    let product = Product(title: title, price: price, phoneNumber: phoneNumber, category: Category(title: category), dictionary: productDictionary)
                                    completionHandler(.success(product))
                                }
                            }
                        }
                        
                    }
                case .failure(let error):
                    print(error)
                    return

                }
        }
    }
    
    func addProduct(json: String, completionHandler: @escaping (Result<String, AddAdsError>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }

        let parametrs: [String: String] = [
            "token": token,
            "ad": json
        ]
        
        AF.request("\(url)/addAd", method: .post, parameters: parametrs)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(arrayLiteral: value)
                    let error = json[0]["error"].stringValue
                    switch error {
                    case "Can not connect to database":
                        completionHandler(.failure(.database))
                    case "Token or ad is not specified":
                        completionHandler(.failure(.tokenOrAdNotSpecified))
                    case "Wrong token":
                        completionHandler(.failure(.wrongToken))
                    case "There is no subcategory, title or price field in ad":
                        completionHandler(.failure(.requiredFieldsNotSpecified))
                    case "Empty title or price":
                        completionHandler(.failure(.titleOrPriseIsEmpty))
                    case "Wrong subcategory":
                        completionHandler(.failure(.wrongCategory))
                    case "Wrong file type":
                        completionHandler(.failure(.wrongFile))
                    default:
                        let id = json[0]["id"].stringValue
                        print(id)
                        completionHandler(.success(id))
                    }
                case .failure(let error):
                    print(error)
                    return
                }
        }
    }
    
    func uploadVideo(token: String, id: String, videoUrl: URL, completionHandler: @escaping () -> Void) {
        
        let parametrs = [
            "token": token,
            "adid": id,
        ]

//        let completeUrl = "\(url):802/uploadVideo?token=\"\(token)\"" + "&adid=\"\(id)\""
        
        let time = Date().timeIntervalSince1970
        
        AF.upload(multipartFormData: { multipartData in
            parametrs.forEach { (key, value) in
                multipartData.append(value.data(using: .utf8)!, withName: key)
            }
            
            do {
                let data = try Data(contentsOf: videoUrl, options: .mappedIfSafe)
                multipartData.append(data, withName: "video", fileName: "\(time).mov", mimeType: "\(time).mov")
            } catch(let error) {
                print(error)
                return
            }
        }, to: "\(url):802/uploadVideo")
            .responseString { response in
                // will add error handler later
                print(response)
                completionHandler()
        }
    }
}
