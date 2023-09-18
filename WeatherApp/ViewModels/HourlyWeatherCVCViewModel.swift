//
//  HourlyWeatherCVCViewModel.swift
//  WeatherApp
//
//  Created by O'lmasbek on 16/09/23.
//

import Foundation

class HourlyWeatherCVCViewModel {
    var hourlyWeather: [HourlyWeather] = []
    
    func getHourlyWeather() {
        let lat = UserDefaults.standard.double(forKey: "latitude")
        let lon = UserDefaults.standard.double(forKey: "longitude")
        NetworkManager.shared.getWeatherWithCoordinate(lat: lat, long: lon) { result in
            switch result {
            case .success(let success):
                self.hourlyWeather = success.forecast.forecastday.first?.hour.map({HourlyWeather(hour: String($0.time.suffix(5)), icon: "", tempC: "\($0.tempC.toInt() ?? 00)")}) ?? [HourlyWeather]()
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
