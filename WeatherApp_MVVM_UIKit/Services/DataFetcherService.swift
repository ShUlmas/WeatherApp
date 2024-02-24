//
//  DataFetcherService.swift
//  WeatherApp_MVVM_UIKit
//
//  Created by O'lmasbek on 08/02/24.
//

import Foundation

class DataFetcherService {
    
    var networkDataFetcher: DataFetcher
    
    init (networkDataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.networkDataFetcher = networkDataFetcher
    }
    
    func fetchWeatherByCity(city: String, completion: @escaping (Weather?) -> Void) {
        let fetchWeatherByCityUrl = API.cityURL(city: city).url
        networkDataFetcher.fetchGenericJSONData(urlString: fetchWeatherByCityUrl, response: completion)
    }
    
    func fetchWeatherByLocation(lat: String, lon: String, completion: @escaping (Weather?) -> Void) {
        let fetchWeatherByLocationUrl = API.coordURL(lat: lat, lon: lon).url
        networkDataFetcher.fetchGenericJSONData(urlString: fetchWeatherByLocationUrl, response: completion)
    }
    
    func readJSONFromFile(completion: @escaping([City]) -> Void) {
        if let path = Bundle.main.path(forResource: "citylist", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let cities = try JSONDecoder().decode([City].self, from: data)
                completion(cities)
            } catch {
                print("Xatolik: \(error)")
            }
        }
    }
}
