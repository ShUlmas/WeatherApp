//
//  WeeklyWeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by O'lmasbek on 15/09/23.
//

import UIKit

class WeeklyWeatherCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "WeeklyWeatherCollectionViewCell"
    
    //MARK: - PROPERTIES
    
    private lazy var horizontalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "Monday"
        label.font = UIFont(name: "Rubik-Medium", size: 17)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.text = "17°/13°"
        label.font = UIFont(name: "Rubik-Bold", size: 20)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let iconImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "cloud.drizzle")
        image.tintColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
//    private let conditionLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Clear"
//        label.font = UIFont(name: "Rubik-Bold", size: 13)
//        label.numberOfLines = 2
//        label.textColor = .white
//        label.textAlignment = .left
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    
    private lazy var iconLabelStack: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.spacing = 4
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: - INIT
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemIndigo
        contentView.layer.cornerRadius = 12
        setupUI()
    }
    
    //MARK: - FUNCTIONS
    
    private func setupUI() {
        contentView.addSubview(horizontalStack)
        iconLabelStack.addArrangedSubview(iconImage)
        //riconLabelStack.addArrangedSubview(conditionLabel)
        
        horizontalStack.addArrangedSubview(dayLabel)
        horizontalStack.addArrangedSubview(tempLabel)
        horizontalStack.addArrangedSubview(iconLabelStack)
        
        
        NSLayoutConstraint.activate([
            
            horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            horizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            horizontalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            horizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            iconImage.widthAnchor.constraint(equalToConstant: 34),
            iconImage.heightAnchor.constraint(equalToConstant: 34)
            
        ])
        
    }
    
    //MARK: - Configure
    
    func configure(model: WeeklyWeather) {
        dayLabel.text = model.date
        //iconImage.image = UIImage(systemName: model.conditionIcon)
        tempLabel.text = model.maxMinTempC
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
