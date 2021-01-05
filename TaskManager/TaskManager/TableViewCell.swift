//
//  MainTableViewCell.swift
//  WhiteNFluffyTestTask
//
//  Created by Andrey on 02/01/2021.
//  Copyright © 2021 Andrey Anoshkin. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let reuseId: String = "TableViewCell"
    
    private(set) var cityNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.numberOfLines = 1
        label.sizeToFit()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.numberOfLines = 1
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        contentView.addSubview(cityNameLabel)
        contentView.addSubview(temperatureLabel)
    }
    
    func configure(weatherItem: WeatherItem) {
        cityNameLabel.text = weatherItem.name

    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            cityNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            cityNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cityNameLabel.widthAnchor.constraint(equalToConstant: 130),
            
            temperatureLabel.centerYAnchor.constraint(equalTo: cityNameLabel.centerYAnchor),
            temperatureLabel.widthAnchor.constraint(equalToConstant: 100),
            temperatureLabel.leadingAnchor.constraint(equalTo: cityNameLabel.trailingAnchor, constant: 20),
        ])
    }
}
