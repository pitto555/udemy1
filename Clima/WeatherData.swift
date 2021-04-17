//
//  WeatherData.swift
//  Clima
//
//  Created by aoka on 2021/04/13.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    //JSONではweatherデータが配列のため[]を使う
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
    let description: String
}
