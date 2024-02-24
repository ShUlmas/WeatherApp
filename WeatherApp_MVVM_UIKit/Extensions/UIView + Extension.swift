//
//  UIView + Extension.swift
//  WeatherApp_MVVM_UIKit
//
//  Created by O'lmasbek on 11/02/24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
}
