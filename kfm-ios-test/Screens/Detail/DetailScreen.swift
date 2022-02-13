//
//  DetailScreen.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 13/02/22.
//

let kDetailScreen = "Detail Screen"

internal final class DetailScreen: Screen<DetailScreenResultModel> {
    
    override var identifier: String {
        return kDetailScreen
    }
    
    override func build() -> ViewController {
        let viewModel = DetailViewModel(screenModel: input)
        let viewController = DetailViewController(viewModel: viewModel)
        
        viewController.navigationEvent.on({ navigation in
            self.event?(navigation)
        })
        
        return viewController
    }
}
