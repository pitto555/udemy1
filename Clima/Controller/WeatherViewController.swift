//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController,UITextFieldDelegate,Advice {
   
    
   
    
   
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var serchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        serchTextField.delegate = self
    }

    @IBAction func searchButton(_ sender: UIButton) {
        
        print(serchTextField.text ?? "")
        serchTextField.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(serchTextField.text ?? "")
        serchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField.text != "" {
            return true
        }else{
            textField.placeholder = "何かかいてね"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = serchTextField.text {
        weatherManager.fetchWeather(cityName: city)
            
        }
        
        serchTextField.text = ""
    }
    
    func didUpdateWeather(weather: WeatherModel) {
       
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureStrning
            self.conditionImageView.image = UIImage(named: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
        
        print(weather.temperatrue)
        
    }
    
    func didFaillWithError(error: Error) {
        print(error)
    }
    
    
    
}

