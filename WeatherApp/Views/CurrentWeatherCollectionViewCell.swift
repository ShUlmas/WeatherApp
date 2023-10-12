//
//  CurrentWeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by O'lmasbek on 15/09/23.
//

import UIKit

class CurrentWeatherCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "CurrentWeatherCollectionViewCell"
    
    //MARK: - Properties
    
    private let regionLabel: UILabel = {
        let label = UILabel()
        label.text = "Tashkent"
        label.font = UIFont(name: "Rubik-Bold", size: 22)
        label.textColor = .label
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Sun, 7 Aug"
        label.font = UIFont(name: "Rubik-Medium", size: 14)
        label.textColor = .label
        return label
    }()
    private let conditionImage: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(systemName: "sun.min")
        imgView.tintColor = .label
        return imgView
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.text = "30 C°"
        label.font = UIFont(name: "Rubik-Bold", size: 30)
        label.textColor = .label
        return label
    }()
    
    private let conditionLabel: UILabel = {
        let label = UILabel()
        label.text = "Clear"
        label.font = UIFont(name: "Rubik-Regular", size: 12)
        label.textColor = .label
        return label
    }()
    
    private lazy var infosStack: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 24
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let windInfoView = ImageAndLabelView(imageName: "wind", info: "10km/h")
    private let rainInfoView = ImageAndLabelView(imageName: "drop", info: "50%")
    private let cloudInfoView = ImageAndLabelView(imageName: "cloud", info: "13%")
    
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpConstraints()
    }
    
    //MARK: - Function
    func setUpConstraints() {
        contentView.addSubviews(regionLabel, dateLabel, conditionImage, conditionLabel, tempLabel, infosStack)
        infosStack.addArrangedSubview(windInfoView)
        infosStack.addArrangedSubview(rainInfoView)
        infosStack.addArrangedSubview(cloudInfoView)
        
        regionLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        conditionImage.translatesAutoresizingMaskIntoConstraints = false
        conditionLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            regionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            regionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            
            conditionImage.topAnchor.constraint(equalTo: regionLabel.bottomAnchor, constant: 20),
            conditionImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            conditionImage.widthAnchor.constraint(equalToConstant: 120),
            conditionImage.heightAnchor.constraint(equalToConstant: 120),
            
            tempLabel.centerYAnchor.constraint(equalTo: conditionImage.centerYAnchor),
            tempLabel.leftAnchor.constraint(equalTo: conditionImage.rightAnchor, constant: 12),
            
            conditionLabel.leftAnchor.constraint(equalTo: tempLabel.rightAnchor, constant: 8),
            conditionLabel.bottomAnchor.constraint(equalTo: tempLabel.bottomAnchor),
            
            infosStack.topAnchor.constraint(equalTo: conditionImage.bottomAnchor, constant: 20),
            infosStack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            infosStack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            infosStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.dateLabel.text = nil
        self.conditionImage.image = nil
        self.regionLabel.text = nil
        self.tempLabel.text = nil
        self.conditionLabel.text = nil
    }
    
    //MARK: - Configure
    func configure(model: CurrentWeather) {
        regionLabel.text = model.name
        conditionLabel.text = model.condition
        conditionImage.downloaded(from: model.iconImageUrl)
        dateLabel.text = model.date
        tempLabel.text = model.temp
        windInfoView.configure(infoText: model.wind)
        rainInfoView.configure(infoText: model.humidity)
        cloudInfoView.configure(infoText: model.cloud)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - View for wind and rain info
class ImageAndLabelView: UIView {
    
    private let iconImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "sun.haze.fill")
        image.tintColor = .systemIndigo
        return image
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: 15)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    init(imageName: String, info: String) {
        super.init(frame: .zero)
        self.iconImage.image = UIImage(systemName: imageName)
        self.label.text = info
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 12
        backgroundColor = .white
        setUpConstraints()
    }
    
    func setUpConstraints() {
        addSubviews(iconImage, label)
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImage.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            iconImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImage.widthAnchor.constraint(equalToConstant: 32),
            iconImage.heightAnchor.constraint(equalToConstant: 32),
            
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            label.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
            label.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
        ])
    }
    
    func configure(infoText: String) {
        label.text = infoText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
