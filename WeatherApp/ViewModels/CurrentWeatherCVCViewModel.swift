//
//  CurrentWeatherCVCViewModel.swift
//  WeatherApp
//
//  Created by O'lmasbek on 16/09/23.
//

import Foundation

class CurrentWeatherCVCViewModel {
    var currentWeather: CurrentWeather
    
    init(currentWeather: CurrentWeather) {
        self.currentWeather = currentWeather
    }
    
    public var locationName: String {
        return currentWeather.name
    }
    
    public var date: String {
        return currentWeather.date
    }
    
    public var tempC: String {
        return currentWeather.temp
    }
    
    public var conditionIcon: String {
        return currentWeather.iconImageUrl
    }
    
    public var conditionLabel: String {
        return currentWeather.condition
    }
    
    public var windKph: String {
        return currentWeather.wind
    }
    
    public var humidity: String {
        return currentWeather.humidity
    }
    
    public var cloud: String {
        return currentWeather.cloud
    }
    
}
