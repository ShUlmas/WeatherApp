//
//  LocationManager.swift
//  WeatherApp
//
//  Created by O'lmasbek on 25/09/23.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    
    static let shared = LocationManager()
    
    private var locationFetchCompletion: ((String) -> Void)?
    private var manager = CLLocationManager()
    private var location: String? {
        didSet {
            guard let location = location else {
                return
            }
            locationFetchCompletion?(location)
        }
    }
    
    public func getCurrentLocation(completion: @escaping(String) -> Void) {
        
        self.locationFetchCompletion = completion
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        
        self.location = "\(lat),\(lon)"
        manager.stopUpdatingLocation()
    }
}
