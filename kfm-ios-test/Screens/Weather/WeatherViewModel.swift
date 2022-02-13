//
//  WeatherViewModel.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 13/02/22.
//

import RxSwift

internal final class WeatherViewModel {
    
    let screenResult: WeatherScreenResultModel
    
    init(screenResult: WeatherScreenResultModel) {
        self.screenResult = screenResult
    }
    
    func fetchWeathers() -> Observable<WeathersResponseModel> {
        return Observable.create { observer in
            let endpoint = WeatherEndpoint.city(self.screenResult.woeid)
            APIProvider.dataRequest(endpoint: endpoint, response: WeathersResponseModel.self) { result in
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
    
    func fetchLogWeather() -> Observable<[ConsolidatedWeather]> {
        return Observable.create { observer in
            let calendar = Calendar.current
            let year = calendar.component(.year, from: Date())
            let month = calendar.component(.month, from: Date())
            let day = calendar.component(.day, from: Date())
            
            let endpoint = WeatherEndpoint.cityToday(self.screenResult.woeid, year, month, day)
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
