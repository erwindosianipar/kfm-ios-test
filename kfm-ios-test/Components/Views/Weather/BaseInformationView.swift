//
//  BaseInformationView.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 13/02/22.
//

import UIKit

internal final class BaseInformationView: UIView {
    
    var data: ConsolidatedWeather? {
        didSet {
            updateData()
        }
    }
    
    var timezone: String? {
        didSet {
            timezoneLabel.text = timezone
        }
    }
    
    private let timezoneLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .systemGray
    }
    
    private let temperatureLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 60, weight: .bold)
    }
    
    private let weatherStatusStackView = UIStackView().then {
        $0.distribution = .equalCentering
        $0.axis = .horizontal
        $0.spacing = 10
    }
    
    private let weatherTextStackView = UIStackView().then {
        $0.distribution = .fill
        $0.axis = .horizontal
        $0.spacing = 10
    }
    
    private let weatherImageView = UIImageView()
    private let weatherStatusLabel = UILabel()
    private let minTemperatureLabel = UILabel()
    private let maxTemperatureLabel = UILabel()
    private let windSpeedLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func commonInit() {
        addSubviews(timezoneLabel, temperatureLabel, weatherStatusStackView, weatherTextStackView)
        timezoneLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.top.equalTo(timezoneLabel.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        weatherStatusStackView.snp.makeConstraints {
            $0.top.equalTo(temperatureLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        weatherStatusStackView.addArrangedSubview(weatherImageView)
        weatherImageView.snp.makeConstraints {
            $0.width.height.equalTo(40)
        }
        
        weatherStatusStackView.addArrangedSubview(weatherStatusLabel)
        
        weatherTextStackView.snp.makeConstraints {
            $0.top.equalTo(weatherStatusStackView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        weatherTextStackView.addArrangedSubview(minTemperatureLabel)
        weatherTextStackView.addArrangedSubview(maxTemperatureLabel)
        weatherTextStackView.addArrangedSubview(windSpeedLabel)
    }
    
    private func updateData() {
        guard let data = self.data else {
            return
        }
        
        temperatureLabel.text = String(Int(data.the_temp)).addWrapper(wrapper: .last(scCelcius))
        weatherStatusLabel.text = String(data.weather_state_name)
            .addWrapper(wrapper: .separate(data.applicable_date.dateFormat(from: scDateDefault, to: scNameAndDate)))
        minTemperatureLabel.text = String(Int(data.min_temp)).addWrapper(wrapper: .wrap(scMin, scCelcius))
        maxTemperatureLabel.text = String(Int(data.max_temp)).addWrapper(wrapper: .wrap(scMax, scCelcius))
        windSpeedLabel.text = String(Int(data.wind_speed)).addWrapper(wrapper: .wrap(scWind, scMph))
        weatherImageView.loadImage(icon: .custom(data.weather_state_abbr))
    }
}
