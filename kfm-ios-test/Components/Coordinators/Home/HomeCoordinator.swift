//
//  HomeCoordinator.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 12/02/22.
//

import UIKit

internal final class HomeCoordinator: NavigationCoordinator {
    
    let window: UIWindow
    
    var navigationController: UINavigationController = UINavigationController()
    
    var screenStack: [Screenable] = []
    
    var onCompleted: ((ScreenResult?) -> Void)?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let screens = [
            HomeScreen(())
        ]
        
        set(screens)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func showScreen(identifier: String, navigation: Navigation) {
        switch identifier {
        case kHomeScreen:
            setHomeScreenNavigation(navigation: navigation)
        case kWeatherScreen:
            setWeatherScreenNavigation(navigation: navigation)
        default:
            break
        }
    }
    
    private func setHomeScreenNavigation(navigation: Navigation) {
        switch navigation {
        case .next(let value):
            if let result = value as? WeatherScreenResultModel {
                push(WeatherScreen(result))
            }
        case .prev:
            return
        }
    }
    
    private func setWeatherScreenNavigation(navigation: Navigation) {
        switch navigation {
        case .next(let value):
            if let result = value as? DetailScreenResultModel {
                present(DetailScreen(result))
            }
        case .prev:
            pop()
        }
    }
}
