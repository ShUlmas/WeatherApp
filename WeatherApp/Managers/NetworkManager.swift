//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by O'lmasbek on 14/09/23.
//

import Foundation
import CoreLocation

class NetworkManager {
    
    static let shared = NetworkManager()
    let baseUrl = "https://api.weatherapi.com/v1"
    let path = "forecast.json"
    let apiKey = "3ffe43130ead454d96f93751231409"
    
    
    
    private init() {}
    
    func getWeatherWithCoordinate(lat: Double, long: Double) {
        
        let urlString = "\(baseUrl)/\(path)?key=\(apiKey)&q=\(lat),\(long)&days=10&aqi=no&alerts=no"
        
        let url = URL(string: urlString)
        
        guard let url = url else {
            return
        }
        //let request = URLRequest(url: url)
        
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
                            let json = try JSONSerialization.jsonObject(with: data)
                            // Process the JSON data
                            print(json)
                        } catch {
                            print("Error parsing JSON: \(error.localizedDescription)")
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

