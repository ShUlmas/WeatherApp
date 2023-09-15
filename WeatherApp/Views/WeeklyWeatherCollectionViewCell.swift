//
//  WeeklyWeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by O'lmasbek on 15/09/23.
//

import UIKit

class WeeklyWeatherCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "WeeklyWeatherCollectionViewCell"

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = #colorLiteral(red: 0, green: 0.2745098039, blue: 0.5294117647, alpha: 1)
        contentView.layer.cornerRadius = 12

    }
    
  
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
