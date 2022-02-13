//
//  ScreenResult.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 12/02/22.
//

internal protocol ScreenResult {}

extension Int: ScreenResult {}
extension String: ScreenResult {}

extension WeatherScreenResultModel: ScreenResult {}
extension DetailScreenResultModel: ScreenResult {}
