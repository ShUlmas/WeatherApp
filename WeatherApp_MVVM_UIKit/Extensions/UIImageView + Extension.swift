//
//  UIImageView + Extension.swift
//  WeatherApp_MVVM_UIKit
//
//  Created by O'lmasbek on 16/02/24.
//

import UIKit


extension UIImageView {
    func loadImage(from url: URL) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if let error = error {
                print("Failed to load image with error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Failed to load image: Invalid response")
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            } else {
                print("Failed to load image: Data is empty or invalid")
            }
        }
        task.resume()
    }
}
