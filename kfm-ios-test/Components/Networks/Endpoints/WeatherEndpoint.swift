//
//  WeatherEndpoint.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 12/02/22.
//

enum WeatherEndpoint {
    case search(String)
    case city(Int)
    case cityToday(Int, Any, Any, Any)
}

extension WeatherEndpoint: Endpoint {
    
    var base: String {
        return "https://www.metaweather.com/api"
    }
    
    var path: String {
        switch self {
        case .search(let terms):
            return "/location/search/?query=\(terms)"
        case .city(let woeid):
            return "/location/\(woeid)/"
        case .cityToday(let woeid, let year, let month, let day):
            return "/location/\(woeid)/\(year)/\(month)/\(day)/"
        }
    }
}
