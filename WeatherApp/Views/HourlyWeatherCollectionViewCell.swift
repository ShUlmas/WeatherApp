//
//  HourlyWeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by O'lmasbek on 15/09/23.
//

import UIKit

class HourlyWeatherCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "HourlyWeatherCollectionViewCell"

    private let tempLabel: UILabel = {
        let label = UILabel()
        label.text = "24C°"
        label.font = UIFont(name: "Rubik-Bold", size: 12)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    private let hourLabel: UILabel = {
        let label = UILabel()
        label.text = "11:00"
        label.font = UIFont(name: "Rubik-Medium", size: 12)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private let iconImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "sun.min")
        image.tintColor = .label
        return image
    }()
    
    private lazy var stacView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .red
        contentView.layer.cornerRadius = 12
        
        setUpUI()
    }
    
    func setUpUI() {
        contentView.addSubview(stacView)
        stacView.addArrangedSubview(hourLabel)
        stacView.addArrangedSubview(iconImage)
        stacView.addArrangedSubview(tempLabel)
        
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        hourLabel.translatesAutoresizingMaskIntoConstraints = false
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stacView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stacView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            stacView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stacView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            
            iconImage.widthAnchor.constraint(equalToConstant: 40),
            iconImage.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.tempLabel.text = nil
        self.hourLabel.text = nil
        self.iconImage.image = nil
    }
    
    //MARK: - Configure
    
    func configure(viewModel: HourlyWeatherCVCViewModel) {
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
