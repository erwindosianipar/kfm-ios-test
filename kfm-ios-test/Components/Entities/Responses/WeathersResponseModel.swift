//
//  WeathersResponseModel.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 13/02/22.
//

struct ConsolidatedWeather: Decodable {
    let id: Int
    let weather_state_name: String
    let weather_state_abbr: String
    let applicable_date: String
    let min_temp: Double
    let max_temp: Double
    let the_temp: Double
    let wind_speed: Double
    let predictability: Int
}

struct WeathersResponseModel: Decodable {
    let consolidated_weather: [ConsolidatedWeather]
    let timezone: String
}
