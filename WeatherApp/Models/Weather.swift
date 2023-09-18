//
//  Weather.swift
//  WeatherApp
//
//  Created by O'lmasbek on 15/09/23.
//

import Foundation


struct Weather: Codable {
    let location: Location
    let current: Current
    let forecast: Forecast
}

struct Location: Codable {
    let name: String // "Tashkent",
    let region: String // "Toshkent",
    let country: String // "Uzbekistan",
    let lat: Double // 41.32,
    let lon: Double // 69.25,
    let tzId: String // "Asia/Tashkent",
    let localtime: String // "2023-09-15 16:27"
}

struct Current: Codable {
    let tempC: Double // 26.0,
    let condition: Condition
    let windKph: Double
    let humidity: Double
    let cloud: Double
}

struct Forecast: Codable {
    let forecastday: [Days]
}

struct Days: Codable {
    let date: String
    let day: Day
    let astro: Astro
    let hour: [Hour]
}

struct Day: Codable {
    let maxtempC: Double
    let mintempC: Double
    let avgtempC: Double
    let maxwindMph: Double
    let maxwindKph: Double
    let condition: Condition
}

struct Hour: Codable {
    let time: String
    let tempC: Double
    let isDay: Int
    let condition: Condition
}

struct Astro: Codable {
    let sunrise: String
    let sunset: String
    let moonrise: String
    let moonset: String
    let moonPhase: String
}

struct Condition: Codable {
    let text: String
    let icon: String
}


