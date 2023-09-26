//
//  HourlyWeatherCVCViewModel.swift
//  WeatherApp
//
//  Created by O'lmasbek on 16/09/23.
//

import Foundation

class HourlyWeatherCVCViewModel {
    
    private let hourlyWeather: HourlyWeather
    
    public var hour: String {
        return hourlyWeather.hour
    }
    
    public var iconUrl: String {
        return hourlyWeather.iconUrl
    }
    
    public var tempC: String {
        return hourlyWeather.tempC
    }
    
    init(hourlyWeather: HourlyWeather) {
        self.hourlyWeather = hourlyWeather
    }
}
