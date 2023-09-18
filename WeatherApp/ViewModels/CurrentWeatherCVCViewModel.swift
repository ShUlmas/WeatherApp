//
//  CurrentWeatherCVCViewModel.swift
//  WeatherApp
//
//  Created by O'lmasbek on 16/09/23.
//

import Foundation
import CoreLocation

class CurrentWeatherCVCViewModel {
    var currentWeather: CurrentWeather = CurrentWeather(regionName: "", date: "", iconImageUrl: "", temp: "", condition: "", wind: "", humidity: "", cloud: "")
    
    
    
    func getCurrentWeather() {
        let lat = UserDefaults.standard.double(forKey: "latitude")
        let lon = UserDefaults.standard.double(forKey: "longitude")
        NetworkManager.shared.getWeatherWithCoordinate(lat: lat, long: lon) { result in
            switch result {
            case .success(let success):
                let currentWeather = CurrentWeather(regionName: success.location.region, date: success.location.localtime, iconImageUrl: "", temp: "\(success.current.tempC)", condition: success.current.condition.text, wind: "\(success.current.windKph)", humidity: "\(success.current.humidity)", cloud: "\(success.current.cloud)")
                self.currentWeather = currentWeather
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
