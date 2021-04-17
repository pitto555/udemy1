//
//  WeatherManager.swift
//  Clima
//
//  Created by aoka on 2021/04/12.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

protocol Advice {
    func didUpdateWeather(weather: WeatherModel)
    func didFaillWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=d7ce984ea3f832627a522f4e4ad99e3f&units=metric"
    
    var delegate:Advice?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    //ネットワーキングを使用しデータを取得する。
    func performRequest(with urlString: String) {
        
        //リクエストに必要な情報
        if let url = URL(string: urlString){
            
            //データ転送を管理するための普通のセッションを作ってる
            let session = URLSession(configuration: .default)
            
            //リクエストの処理をタスクとして実行
            let task = session.dataTask(with: url) { (data, response, error) in
                
                guard error == nil else {
                    self.delegate?.didFaillWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if  let weather =  paraseJSON(safeData){
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                    
                }
            }
            //taskの中身が開始される
            task.resume()
        }
        
        
        
        //データを取得して デコードしてstructに入れ込んで天気データJSONから気温と天気のデータを取得してる。
        func paraseJSON(_ weatherData: Data) -> WeatherModel?{
           
            let decoder = JSONDecoder()
            
            //デコードするstructがある場所とデコードするデータこれやで を変数に入れてる
            do{
                let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
                let id = decodedData.weather[0].id
                let temp = decodedData.main.temp
                let name = decodedData.name
                
                //天気の保存場所へGo
                let weather = WeatherModel(conditionId: id, cityName: name, temperatrue: temp)
                return weather
                
            }catch {
                delegate?.didFaillWithError(error: error)
                return nil
            }
        }
       
    }
    
}
