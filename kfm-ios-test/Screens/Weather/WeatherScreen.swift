//
//  WeatherScreen.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 13/02/22.
//

let kWeatherScreen = "Weather Screen"

internal final class WeatherScreen: Screen<WeatherScreenResultModel> {
    
    override var identifier: String {
        return kWeatherScreen
    }
    
    override func build() -> ViewController {
        let viewModel = WeatherViewModel(screenResult: input)
        let viewController = WeatherViewController(viewModel: viewModel)
        
        viewController.navigationEvent.on({ navigation in
            self.event?(navigation)
        })
        
        return viewController
    }
}
