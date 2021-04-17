//
//  WeatherModel.swift
//  Clima
//
//  Created by aoka on 2021/04/13.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

//天気のデータの保存場所
struct WeatherModel {
    //はれ,くもり,あめ等をくべつするID
    let conditionId: Int
    //街の名前
    let cityName: String
    //温度
    let temperatrue: Double
    
    //温度を小数点第1位にして変数にいれる
    var temperatureStrning:String {
        String(format:"%.1f",temperatrue)
    }
    
    //天気のコンディションを変数に入れる
    var conditionName: String {
        
        //取得したIDの数字によってコンデイションを文字列型にして分けて取得
        switch conditionId {
        case 200...232:
            return "cloud.bold"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bold"
        default:
            return "cloud"
        }

    }
    
}
