//
//  HomeViewViewModel.swift
//  WeatherApp
//
//  Created by O'lmasbek on 30/09/23.
//

import Foundation

class HomeViewViewModel {
    
    public var currentWeather: CurrentWeather = CurrentWeather(name: "", date: "", iconImageUrl: "", temp: "", condition: "", wind: "", humidity: "", cloud: "")
    public var houryWeather: [HourlyWeather] = []
    public var weekyWeather: [WeeklyWeather] = []
    
    init() {
        getWeather()
    }
    
    
    func getWeather() {
        LocationManager.shared.getCurrentLocation { location in
            NetworkManager.shared.getWeatherWithCoordinate(location: location) { result in
                switch result {
                case .success(let weather):
                    
                    self.currentWeather = CurrentWeather(
                        name: weather.location.name,
                        date: "\(weather.location.localtime)",
                        iconImageUrl: "https:\(weather.current.condition.icon)",
                        temp: "\(weather.current.tempC.toInt() ?? 00) C°",
                        condition: weather.current.condition.text,
                        wind: "\(weather.current.windKph.toInt() ?? 00) km/h",
                        humidity: "\(weather.current.humidity.toInt() ?? 00) %",
                        cloud: "\(weather.current.cloud.toInt() ?? 00) %")
                    
                    self.houryWeather = weather.forecast.forecastday[0].hour.map({HourlyWeather(hour: "\($0.time.suffix(5))", iconUrl: "https:\($0.condition.icon)", tempC: "\($0.tempC.toInt() ?? 0) C°")})
                    
                    self.weekyWeather = weather.forecast.forecastday.map({WeeklyWeather(date: $0.date, maxMinTempC: "\($0.day.mintempC.toInt() ?? 00) C° / \($0.day.maxtempC.toInt() ?? 00) C°", conditionText: $0.day.condition.text, conditionIconUrl: "https:\($0.day.condition.icon)")})
                    
                    print(self.weekyWeather[0].date as Any)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

