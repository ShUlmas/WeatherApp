//
//  CityTableViewCell.swift
//  WeatherApp_MVVM_UIKit
//
//  Created by O'lmasbek on 18/02/24.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    static let cellIdentifier: String = "CityTableViewCell"
    
    //MARK: - UI
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.tintColor = .gray
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var pinButtonAction: (() -> Void)?
    //MARK: - INIT

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(cityNameLabel, addButton)
        addConstraints()
        self.selectionStyle = .none
        addButton.addTarget(self, action: #selector(pinButtonTapped), for: .touchUpInside)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            cityNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cityNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            
            addButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            addButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cityNameLabel.text = nil
    }
    
    @objc func pinButtonTapped() {
        pinButtonAction?()
    }
    
    func configureCell(with viewModel: CityTableViewCellViewModel) {
        cityNameLabel.text = viewModel.cityName
        if viewModel.isPin {
            addButton.setImage(UIImage(systemName: "minus.circle.fill"), for: .normal)
        } else {
            addButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
