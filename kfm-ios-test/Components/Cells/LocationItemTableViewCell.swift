//
//  LocationItemTableViewCell.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 14/02/22.
//

import UIKit

internal final class LocationItemTableViewCell: UITableViewCell {
    
    var data: HomeScreenResultModel? {
        didSet {
            setupView()
        }
    }
    
    private let cardView = UIView().then {
        $0.backgroundColor = .secondarySystemBackground
        $0.layer.cornerRadius = 10
    }
    
    private let weatherStatusImageView = UIImageView()
    private let cityLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 16)
    }
    
    private let dateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 10)
    }
    
    private let temperatureLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 40, weight: .light)
        $0.textAlignment = .right
    }
    
    private let weatherStatusStackView = UIStackView().then {
        $0.distribution = .equalCentering
        $0.axis = .horizontal
        $0.spacing = 5
    }
    
    private let weatherStatusLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 10)
    }
    
    private let minTemperatureLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 10)
    }
    
    private let maxTemperatureLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 10)
    }
    
    private func setupView() {
        layer.cornerRadius = 10
        selectionStyle = .none
        
        contentView.addSubview(cardView)
        cardView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
        
        cardView.addSubviews(weatherStatusImageView, temperatureLabel, cityLabel, dateLabel, weatherStatusLabel, weatherStatusStackView)
        
        temperatureLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.right.equalToSuperview().inset(10)
            $0.width.equalTo(100)
        }
        
        weatherStatusImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(13)
            $0.left.equalToSuperview().offset(10)
            $0.width.height.equalTo(30)
        }
        
        cityLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalTo(weatherStatusImageView.snp.right).offset(10)
            $0.right.equalTo(temperatureLabel.snp.left).offset(-10)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(cityLabel.snp.bottom).offset(5)
            $0.left.equalTo(weatherStatusImageView.snp.right).offset(10)
            $0.right.equalTo(cityLabel.snp.right)
        }
        
        weatherStatusLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        weatherStatusStackView.snp.makeConstraints {
            $0.top.equalTo(temperatureLabel.snp.bottom).offset(20)
            $0.trailing.bottom.equalToSuperview().inset(10)
            $0.height.equalTo(10)
        }
        
        weatherStatusStackView.addArrangedSubview(minTemperatureLabel)
        weatherStatusStackView.addArrangedSubview(maxTemperatureLabel)
        
        updateData()
    }
    
    private func updateData() {
        guard let data = self.data else {
            return
        }
        
        cityLabel.text = data.meta.city
        weatherStatusImageView.loadImage(icon: .custom(data.data.weather_state_abbr))
        weatherStatusLabel.text = data.data.weather_state_name
        temperatureLabel.text = String(Int(data.data.the_temp)).addWrapper(wrapper: .last(scCelcius))
        minTemperatureLabel.text = String(Int(data.data.min_temp)).addWrapper(wrapper: .wrap(scMin, scCelcius))
        maxTemperatureLabel.text = String(Int(data.data.max_temp)).addWrapper(wrapper: .wrap(scMax, scCelcius))
        dateLabel.text = data.data.applicable_date.dateFormat(from: scDateDefault, to: scNameAndDate)
    }
}
