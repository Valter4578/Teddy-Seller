//
//  GeodecoderService.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 25.05.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class GeodecoderService {
    private let link = "https://geocode-maps.yandex.ru/1.x/"
    
    func getCity(latitude: Double, longitude: Double, completionHandler: @escaping (String) -> ()) {
        
        let parametrs: [String: Any] = [
            "apikey": "4c1b1845-a05f-45cd-8838-1b4b358a5fc1",
            "format": "json",
            "geocode": "\(longitude), \(latitude)"
        ]
        
        AF.request(link, method: .get, parameters: parametrs)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(arrayLiteral: value)
                    
                    print(value)
                    
                    let city = json[0]["response"]["GeoObjectCollection"]["featureMember"][0]["GeoObject"]["metaDataProperty"]["GeocoderMetaData"]["Address"]["Components"][4]["name"].stringValue
                    
                    completionHandler(city)
                    
                case .failure(let error):
                    print(error)
                    return
                }
        }
    }
}
