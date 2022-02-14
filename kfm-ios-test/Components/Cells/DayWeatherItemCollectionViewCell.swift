//
//  DayWeatherItemCollectionViewCell.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 13/02/22.
//

import UIKit

internal final class DayWeatherItemCollectionViewCell: UICollectionViewCell {
    
    var data: ConsolidatedWeather? {
        didSet {
            updateData()
        }
    }
    
    private let dateLabel = UILabel().then {
        $0.textAlignment = .center
    }
    
    private let weatherStatusImageView = UIImageView()
    
    private let temperatureLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 20)
    }
    
    private let windSpeedLabel = UILabel().then {
        $0.textAlignment = .center
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
        addSubviews(dateLabel, weatherStatusImageView, temperatureLabel, windSpeedLabel)
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(20)
        }
        
        weatherStatusImageView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(20)
            $0.width.height.equalTo(30)
            $0.centerX.equalToSuperview()
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.top.equalTo(weatherStatusImageView.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        windSpeedLabel.snp.makeConstraints {
            $0.top.equalTo(temperatureLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().offset(-15)
            $0.height.equalTo(20)
        }
    }
    
    private func updateData() {
        guard let data = self.data else {
            return
        }
        
        dateLabel.text = data.applicable_date.dateFormat(from: scDateDefault, to: scNameAndDate)
        weatherStatusImageView.loadImage(icon: .custom(data.weather_state_abbr))
        temperatureLabel.text = String(Int(data.the_temp)).addWrapper(wrapper: .last(scCelcius))
        windSpeedLabel.text = String(Int(data.wind_speed)).addWrapper(wrapper: .wrap(scWindEmoji, scMph))
    }
}
