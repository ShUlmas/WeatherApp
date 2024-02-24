//
//  NetworkManager.swift
//  WeatherApp_MVVM_UIKit
//
//  Created by O'lmasbek on 07/02/24.
//

import Foundation

enum API {
    case cityURL(city: String)
    case coordURL(lat: String, lon: String)
    
    var url: String {
        switch self {
        case .cityURL(let city):
            let apiKey = "2d53bfe37c8a4157b02163849241502"
            let urlString = "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(city)&days=10"
            return urlString
        case .coordURL(let lat, let lon):
            let apiKey = "2d53bfe37c8a4157b02163849241502"
            let urlString = "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(lat),\(lon)&days=10"
            return urlString
        }
    }
}
