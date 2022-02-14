//
//  HomeViewModel.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 12/02/22.
//

import RxSwift

internal final class HomeViewModel {
    
    var cities: [LocationSearchResponseModel] = []
    
    func searchCity(name: String) -> Observable<[LocationSearchResponseModel]> {
        return Observable.create { observer in
            let endpoint = WeatherEndpoint.search(name)
            APIProvider.dataRequest(endpoint: endpoint, response: [LocationSearchResponseModel].self) { result in
                switch result {
                case .success(let result):
                    observer.onNext(result)
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    func fetchLogWeather(woeid: Int) -> Observable<[ConsolidatedWeather]> {
        return Observable.create { observer in
            let calendar = Calendar.current
            let year = calendar.component(.year, from: Date())
            let month = calendar.component(.month, from: Date())
            let day = calendar.component(.day, from: Date())
            
            let endpoint = WeatherEndpoint.cityToday(woeid, year, month, day)
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
