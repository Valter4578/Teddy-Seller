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
    private let link = "https://geocode-maps.yandex.ru/1.x/?apikey="
    private let apiKey = "4c1b1845-a05f-45cd-8838-1b4b358a5fc1"
    private let format = "&format=json"
    
    func getCity(latitude: Double, longitude: Double, completionHandler: @escaping (String) -> ()) {
        let stringUrl = link + apiKey + format + "&geocode=\(longitude),\(latitude)"
        guard let url = URL(string: stringUrl) else { return }
        
        AF.request(url).responseJSON { (response) in
            guard let data = response.data else { return }
            guard let json = try? JSON(data: data) else { return }
            let adress = json["response"]["GeoObjectCollection"]["featureMember"][0]["GeoObject"]["description"].stringValue
            completionHandler(adress.replacingOccurrences(of: ", Россия", with: ""))
        }
    }
}
