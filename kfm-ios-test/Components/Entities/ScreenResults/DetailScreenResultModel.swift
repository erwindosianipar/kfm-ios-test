//
//  DetailScreenResultModel.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 13/02/22.
//

struct DetailScreenResultModel: Decodable {
    
    let woeid: Int
    let isNeedToRequestHistories: Bool
    let consolidatedWeather: ConsolidatedWeather
    
    init(woeid: Int, isNeedToRequestHistories: Bool, consolidatedWeather: ConsolidatedWeather) {
        self.woeid = woeid
        self.isNeedToRequestHistories = isNeedToRequestHistories
        self.consolidatedWeather = consolidatedWeather
    }
}
