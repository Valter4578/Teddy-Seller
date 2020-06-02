//
//  CityFinderService.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 26.05.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CityFinderService {
    static func getCities(city: String, completionHandler: @escaping (String) -> Void) {
        let parametrs:[String:String] = [
            "access_token": "bb6d7c5ebb6d7c5ebb6d7c5e87bb1f49a9bbb6dbb6d7c5ee5a04e34761913fb77bdd90d",
            "v":"5.5",
            "need_all":"0",
            "count":"15",
            "q":city,
            "country_id":"1",
        ]
        
        AF.request("http://api.vk.com/method/database.getCities?", parameters: parametrs)
            .responseJSON { (response) in
                guard let data = response.data else { return }
                guard let json = try? JSON(data: data) else { return }
                
                for i in 0...14 {
                    let cityName = json["response"]["items"][i]["title"].stringValue
                    completionHandler(cityName)
                }
        }
    }
}
