//
//  Double + Extension.swift
//  WeatherApp_MVVM_UIKit
//
//  Created by O'lmasbek on 16/02/24.
//

import Foundation

extension Double {
    func toRoundOfInt() -> Int {
        let doubleValue = self
        let fractionalPart = doubleValue - Double(Int(doubleValue))
        if fractionalPart >= 0.5 {
            return Int(doubleValue) + 1
        } else {
            return Int(doubleValue)
        }
    }
}
