//
//  HourlyWeatherCollectionViewCellViewModel.swift
//  WeatherApp_MVVM_UIKit
//
//  Created by O'lmasbek on 11/02/24.
//

import Foundation

class HourlyWeatherCollectionViewCellViewModel {
    let hour: String
    let iconUrl: String
    let tempC: Double
    
    init(hour: Hour) {
        self.hour = hour.time
        self.iconUrl = hour.condition.icon
        self.tempC = hour.tempC
    }
    
    public var displayTempC: String {
        return "\(tempC.toRoundOfInt()) C°"
    }
    
    public var displayHour: String {
        hour.toDate(format: "yyyy-MM-dd HH:mm", toFormat: "HH:mm")
    }
    
    public var fullIconUrl: URL {
        return URL(string: "https:" + iconUrl) ?? URL(filePath: "")
    }
}
