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
    
    //https://api.weatherapi.com/v1/forecast.json?key=31220cc3996d42daa9454459231809&q=Tashkent&days=10&aqi=no&alerts=no
    
    let baseUrl = "https://api.weatherapi.com/v1"
    let path = "forecast.json"
    let apiKey = "31220cc3996d42daa9454459231809"
    
    //MARK: - REQUEST WITH COORDINATE
    public func getWeatherWithCoordinate(location: String, completion: @escaping(Result<Weather, Error>) -> Void ) {
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
                            completion(.success(weather))
                        } catch {
                            completion(.failure(error))
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


