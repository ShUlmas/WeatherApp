//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by O'lmasbek on 14/09/23.
//

import Foundation
import CoreLocation

struct NetworkManager {
    
    static let shared = NetworkManager()
    let baseUrl = "https://api.weatherapi.com/v1"
    let path = "forecast.json"
    let apiKey = "31220cc3996d42daa9454459231809"
    //31220cc3996d42daa9454459231809
    //3ffe43130ead454d96f93751231409 eski
        
    //MARK: - REQUEST WITH COORDINATE
    func getWeatherWithCoordinate(lat: Double, long: Double, completion: @escaping(Result<Weather, Error>) -> Void ) {
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
    //MARK: -  REQUEST WITH CITY NAME
    func getWeatherWithCoordinate(regionName: String) {
        
        let urlString = "\(baseUrl)/\(path)?key=\(apiKey)&q=\(regionName)&days=1&aqi=no&alerts=no"
        request(with: urlString)
    }
    //MARK: - REQUEST WITH URLSTRING
    func request(with urlString: String) {
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
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            _ = try decoder.decode(Weather.self, from: data)
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

