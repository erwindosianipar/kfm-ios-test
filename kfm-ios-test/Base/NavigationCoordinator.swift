//
//  NavigationCoordinator.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 12/02/22.
//

import UIKit

protocol NavigationCoordinator: AnyObject {
    
    var navigationController: UINavigationController { get set }
    var screenStack: [Screenable] { get set }
    var onCompleted: ((ScreenResult?) -> Void)? { get set }
    
    func start()
    
    func showScreen(identifier: String, navigation: Navigation)
}

extension NavigationCoordinator {
    
    func set(_ screens: [Screenable], animated: Bool = true) {
        let viewControllers: [ViewController] = screens
            .map({ screen -> ViewController in
                screen.event = { navigation in
                    self.showScreen(identifier: screen.identifier, navigation: navigation)
                }
                
                return screen.build()
            })
        
        screenStack = screens
        
        navigationController.setViewControllers(viewControllers, animated: animated)
    }
    
    func pop(identifier: String? = nil) {
        guard !screenStack.isEmpty else {
            return
        }
        
        var screenIndex: Int?
        
        if identifier == nil {
            screenStack.removeLast()
            
            if navigationController.children.count == 2 {
                self.navigationController.tabBarController?.tabBar.isHidden = false
            }
            
            navigationController.popViewController(animated: true)
            return
        }
        
        screenStack.enumerated().forEach({ index, screen in
            if screen.identifier == identifier {
                screenIndex = index
            }
        })
        
        let startIndex = navigationController.viewControllers.startIndex
        let endIndex = navigationController.viewControllers.endIndex
        
        guard let index = screenIndex, !navigationController.viewControllers.isEmpty, (index >= startIndex) && (index <= endIndex) else {
            return
        }
        
        for index in ((index + 1)..<screenStack.count).reversed() {
            screenStack.remove(at: index)
        }
        
        if screenStack.count == 1 {
            self.navigationController.tabBarController?.tabBar.isHidden = false
        }
        
        navigationController.popToViewController(navigationController.viewControllers[index], animated: true)
    }
    
    func push(_ screen: Screenable) {
        screen.event = { navigation in
            self.showScreen(identifier: screen.identifier, navigation: navigation)
        }
        
        screenStack.append(screen)
        
        if navigationController.children.count > 0 {
            self.navigationController.tabBarController?.tabBar.isHidden = true
        }
        
        let viewController = screen.build()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func present(_ screen: Screenable) {
        screen.event = { navigation in
            self.showScreen(identifier: screen.identifier, navigation: navigation)
        }
        
        navigationController.present(screen.build(), animated: true, completion: nil)
    }
}
