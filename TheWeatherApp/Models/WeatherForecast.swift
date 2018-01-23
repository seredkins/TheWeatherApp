//
//  WeatherForecast.swift
//  TheWeatherApp
//
//  Created by theSERG on 23/01/2018.
//  Copyright © 2018 seredkins. All rights reserved.
//

import Foundation

class WeatherForecast {
    init(city: String, weather: Dictionary<String, String>) {
        self.city = city
        self.weather = weather
    }
    
    let city: String
    let weather: Dictionary<String, String>
}
