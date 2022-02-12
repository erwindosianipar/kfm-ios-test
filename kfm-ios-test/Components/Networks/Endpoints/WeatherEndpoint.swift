//
//  WeatherEndpoint.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 12/02/22.
//

enum WeatherEndpoint {
    case search(String)
}

extension WeatherEndpoint: Endpoint {
    var base: String {
        return "https://www.metaweather.com/api"
    }
    
    var path: String {
        switch self {
        case .search(let terms):
            return "/location/search/?query=\(terms)"
        }
    }
}
