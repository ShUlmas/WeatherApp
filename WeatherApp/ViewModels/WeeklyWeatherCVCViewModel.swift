//
//  WeeklyWeatherCVCViewModel.swift
//  WeatherApp
//
//  Created by O'lmasbek on 16/09/23.
//

import Foundation


class WeeklyWeatherCVCViewModel {
    
    var weeklyWeather: [WeeklyWeather] = []
    
    func getWeeklyWeather() {
        let lat = UserDefaults.standard.double(forKey: "latitude")
        let lon = UserDefaults.standard.double(forKey: "longitude")
        NetworkManager.shared.getWeatherWithCoordinate(lat: lat, long: lon) { result in
            switch result {
            case .success(let weather):
                 let weatherW = weather.forecast.forecastday.map({
                    WeeklyWeather(date: $0.date, maxMinTempC: "\($0.day.maxtempC.toInt() ?? 00)C°/\($0.day.mintempC.toInt() ?? 00)C°", conditionText: $0.day.condition.text, conditionIcon: "")
                })
                self.weeklyWeather = weatherW
            case .failure(let error):
                print(error)
            }
        }
    }
}
