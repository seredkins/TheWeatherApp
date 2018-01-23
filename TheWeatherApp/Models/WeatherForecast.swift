//
//  WeatherForecast.swift
//  TheWeatherApp
//
//  Created by theSERG on 23/01/2018.
//  Copyright © 2018 seredkins. All rights reserved.
//

import Foundation

struct WeatherForecast : Decodable {
    enum MyStructKeys: String, CodingKey {
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MyStructKeys.self)
        let cityName: String = try container.decode(String.self, forKey: .name)
        
        self.init(name: cityName)
    }
    init(name: String) {
        city = City(cityName: name)
    }
    struct City {
        init(cityName: String) {
            name = cityName
        }
        let name: String
    }
    let city: City
//    let list: Dictionary<String, String>
}
