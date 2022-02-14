//
//  HomeScreenResultModel.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 14/02/22.
//

struct HomeScreenResultModel: Decodable, Encodable {
    
    var meta: WeatherScreenResultModel
    var data: ConsolidatedWeather
}
