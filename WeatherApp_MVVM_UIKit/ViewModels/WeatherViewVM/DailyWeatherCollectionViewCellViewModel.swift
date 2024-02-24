//
//  DailyWeatherCollectionViewCellViewModel.swift
//  WeatherApp_MVVM_UIKit
//
//  Created by O'lmasbek on 11/02/24.
//

import Foundation

class DailyWeatherCollectionViewCellViewModel {
    let date: String
    let imageUrl: String
    let avgTempC: Double
    let conditionTxt: String
    
    init(forecastDay: Forecastday) {
        self.date = forecastDay.date
        self.avgTempC = forecastDay.day.avgtempC
        self.conditionTxt = forecastDay.day.condition.text
        self.imageUrl = forecastDay.day.condition.icon
    }
    
    public var displayAvgTempC: String {
        return "\(avgTempC.toRoundOfInt()) C°"
    }
    
    public var fullImageUrl: URL {
        return URL(string: "https:" + imageUrl)!
    }

    public var displayDate: String {
        return date.toDate(format: "yyyy-MM-dd", toFormat: "EEEE, MMM d")
    }
}
