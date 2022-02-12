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
}
