//
//  DetailViewModel.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 13/02/22.
//

import RxSwift

internal final class DetailViewModel {
    
    var screenModel: DetailScreenResultModel
    
    init(screenModel: DetailScreenResultModel) {
        self.screenModel = screenModel
    }
    
    func fetchLogWeather() -> Observable<[ConsolidatedWeather]> {
        return Observable.create { observer in
            let date = self.screenModel.consolidatedWeather.applicable_date
            let year = date.dateFormat(from: scDateDefault, to: scYear)
            let month = date.dateFormat(from: scDateDefault, to: scMonth)
            let day = date.dateFormat(from: scDateDefault, to: scDay)
            
            let endpoint = WeatherEndpoint.cityToday(self.screenModel.woeid, year, month, day)
            APIProvider.dataRequest(endpoint: endpoint, response: [ConsolidatedWeather].self) { result in
                switch result {
                case .success(let response):
                    observer.onNext(response)
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}
