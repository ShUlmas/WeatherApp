//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by O'lmasbek on 14/09/23.
//
import Foundation
import UIKit

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    let baseUrl = "https://api.weatherapi.com/v1"
    let path = "forecast.json"
    let apiKey = "31220cc3996d42daa9454459231809"
    
    public private(set) var currentWeather: CurrentWeather?
    public private(set) var hourlyWeather: [HourlyWeather] = []
    public private(set) var weeklyWeather: [WeeklyWeather] = []
    
    //MARK: - REQUEST WITH COORDINATE
    public func getWeatherWithCoordinate(location: String, completion: @escaping() -> Void ) {
        let urlString = "\(baseUrl)/\(path)?key=\(apiKey)&q=\(location)&days=10&aqi=no&alerts=no"
        let url = URL(string: urlString)
        
        guard let url = url else {
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            // Handle the response here
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            // Check the HTTP status code
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    // Parse and handle the data
                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            
                            let weather = try decoder.decode(Weather.self, from: data)
                            self.currentWeather = CurrentWeather(
                                name: weather.location.name,
                                date: weather.location.localtime,
                                iconImageUrl: weather.current.condition.icon,
                                temp: "\(weather.current.tempC) C°",
                                condition: weather.current.condition.text,
                                wind: "\(weather.current.windKph) km/h",
                                humidity: "\(weather.current.humidity) %",
                                cloud: "\(weather.current.cloud) %")
                            
                            let hourlyWeather = weather.forecast.forecastday.first?.hour.map({HourlyWeather(
                                hour: String($0.time.suffix(5)),
                                iconUrl: "https://\($0.condition.icon.dropFirst(2))",
                                tempC: "\($0.tempC.toInt() ?? 00)")}) ?? [HourlyWeather]()
                            self.hourlyWeather = hourlyWeather
                            
                            let weeklyWeather = weather.forecast.forecastday.map({
                                WeeklyWeather(
                                    date: $0.date, 
                                    maxMinTempC: "\($0.day.maxtempC.toInt() ?? 00)C°/\($0.day.mintempC.toInt() ?? 00)C°",
                                    conditionText: $0.day.condition.text, 
                                    conditionIconUrl: "https://\($0.day.condition.icon.dropFirst(2))")
                            })
                            self.weeklyWeather = weeklyWeather
                            
                            print(self.currentWeather!)
                            print(self.hourlyWeather)
                            print(self.weeklyWeather)
                        } catch {
                            print(error)
                        }
                    }
                } else {
                    print("HTTP Status Code: \(httpResponse.statusCode)")
                }
            }
        }
        // Start the data task
        task.resume()
    }
}


