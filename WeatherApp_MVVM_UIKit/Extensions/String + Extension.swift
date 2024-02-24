//
//  String + Extension.swift
//  WeatherApp_MVVM_UIKit
//
//  Created by O'lmasbek on 16/02/24.
//

import Foundation

extension String {
    func toDate(format: String, toFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = toFormat
            let formattedDate = dateFormatter.string(from: date)
            return formattedDate
        } else {
            return "error formatted date"
        }
    }
}
