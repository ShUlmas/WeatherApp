//
//  WeeklyWeatherCVCViewModel.swift
//  WeatherApp
//
//  Created by O'lmasbek on 16/09/23.
//

import Foundation


class WeeklyWeatherCVCViewModel {
    
    private let weeklyWeather: WeeklyWeather
    
    public var date: String {
        return weeklyWeather.date
    }
    
    public var tempC: String {
        return weeklyWeather.maxMinTempC
    }
    
    public var iconUrl: String {
        return weeklyWeather.conditionIconUrl
    }
    
    init(weeklyWeather: WeeklyWeather) {
        self.weeklyWeather = weeklyWeather
    }

}
