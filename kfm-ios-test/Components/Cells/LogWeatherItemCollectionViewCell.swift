//
//  LogWeatherItemCollectionViewCell.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 13/02/22.
//

import UIKit

internal final class LogWeatherItemCollectionViewCell: UICollectionViewCell {
    
    var data: ConsolidatedWeather? {
        didSet {
            updateData()
        }
    }
    
    private let weatherStatusImageView = UIImageView()
    
    private let temperatureLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 10)
    }
    
    private let windSpeedLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 10)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func commonInit() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 10
        addSubviews(weatherStatusImageView, temperatureLabel, windSpeedLabel)
        weatherStatusImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.width.height.equalTo(20)
            $0.centerX.equalToSuperview()
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.top.equalTo(weatherStatusImageView.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        windSpeedLabel.snp.makeConstraints {
            $0.top.equalTo(temperatureLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.height.equalTo(20)
        }
    }
    
    private func updateData() {
        guard let data = self.data else {
            return
        }
        
        weatherStatusImageView.loadImage(icon: .custom(data.weather_state_abbr))
        temperatureLabel.text = String(Int(data.the_temp)).addWrapper(wrapper: .last(scCelcius))
        windSpeedLabel.text = String(Int(data.wind_speed)).addWrapper(wrapper: .wrap(scWindEmoji, scMph))
    }
}
