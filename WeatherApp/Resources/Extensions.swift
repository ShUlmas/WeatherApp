//
//  Extensions.swift
//  WeatherApp
//
//  Created by O'lmasbek on 16/09/23.
//

import Foundation
import UIKit


extension Double {
    func toInt() -> Int? {
        if self >= Double(Int.min) && self < Double(Int.max) {
            return Int(self)
        } else {
            return nil
        }
    }
}

extension String {
    
    func toDate(withFormat format: String = "MM-dd-yyyy")-> Date?{
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tashkent")
        dateFormatter.locale = Locale(identifier: "uz")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        
        return date
        
    }
}

extension Date {
    func toString(withFormat format: String = "EEEE") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "uz")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tashkent")
        dateFormatter.calendar = Calendar(identifier: .persian)
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)
        
        return str
    }
}

//MARK: -  Extension UIView
extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
    
    func addBlurEffect(style: UIBlurEffect.Style) {
        // Create a blur effect
        let blurEffect = UIBlurEffect(style: style)
        
        // Create a blur effect view
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        // Set the frame to match the view's bounds
        blurEffectView.frame = self.bounds
        
        // Add the blur effect view as a subview, behind all other subviews
        self.insertSubview(blurEffectView, at: 0)
    }
    
}

//MARK: - DOWNLOAD IMAGE
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

