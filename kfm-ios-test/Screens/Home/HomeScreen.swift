//
//  HomeScreen.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 12/02/22.
//

let kHomeScreen = "Home Screen"

internal final class HomeScreen: Screen<Void> {
    
    override var identifier: String {
        return kHomeScreen
    }
    
    override func build() -> ViewController {
        let viewModel = HomeViewModel()
        let viewController = HomeViewController(viewModel: viewModel)
        
        viewController.navigationEvent.on({ navigation in
            self.event?(navigation)
        })
        
        return viewController
    }
}
