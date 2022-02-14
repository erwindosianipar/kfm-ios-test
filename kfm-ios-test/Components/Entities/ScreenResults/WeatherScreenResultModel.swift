//
//  WeatherScreenResultModel.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 13/02/22.
//

struct WeatherScreenResultModel: Decodable, Encodable {
    
    let city: String
    let woeid: Int
    
    init(data: LocationSearchResponseModel) {
        self.city = data.title
        self.woeid = data.woeid
    }
}
