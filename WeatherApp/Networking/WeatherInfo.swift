//
//  WeatherInfo.swift
//  WeatherApp
//
//  Created by User on 7/24/20.
//  Copyright © 2020 Aidin. All rights reserved.
//

import Foundation

class WeatherInfo {
    
    var view = MainViewController()
    
    func getURL(lat: Double, lon: Double) {
        let url = "http://wapi.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=305b4bde581a31882242b4d4358bf25f"
        guard let url1 = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url1) { (data, _, error) in
            if let data = data, error == nil {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                    guard let weatherDetails = json["weather"] as?[[String: Any]], let weatherMain = json["main"] as? [String: Any] else { return }
                    let temp = Int((weatherMain["temp"] as? Double ?? 0) - 273.15)
                    guard let image = (weatherDetails.first?["icon"] as? String) else { return }
                    guard let name = json["name"] as? String else { return }
                    guard let main = (weatherDetails.first?["main"] as? String) else { return }
                    
                    DispatchQueue.main.async {
                        self.view.setWeather(temp: temp, name: name, image: image, mainDescription: main)
                    }
                    
                } catch {
                    print("Error")
                }
            }
        }
        task.resume()
    }
    
    func getCurrentDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let currentDate = dateFormatter.string(from: date)
        return currentDate
    }
    
}
