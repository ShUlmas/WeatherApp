//
//  CityTableViewCellViewModel.swift
//  WeatherApp_MVVM_UIKit
//
//  Created by O'lmasbek on 18/02/24.
//

import Foundation


class CityTableViewCellViewModel {
    
    let cityName: String
    var isPin: Bool
    
    init(city: City, isPin: Bool = false) {
        self.cityName = city.name
        self.isPin = isPin
    }
}
