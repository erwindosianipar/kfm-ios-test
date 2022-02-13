//
//  ViewController.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 11/02/22.
//

import UIKit

class ViewController: UIViewController {
    
    let navigationEvent = NavigationEvent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        setupNavigationComponent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupNavigationComponent() {
        if viewControllers().count > 1 {
            let navigationItemLeftView = NavigationItemLeftView()
            navigationItemLeftView.delegate = self
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navigationItemLeftView)
        }
    }
    
    private func viewControllers() -> [UIViewController] {
        guard let controllers = navigationController?.viewControllers else {
            return []
        }
        
        return controllers
    }
}

extension ViewController: NavigationItemLeftViewDelegate {
    
    func navigationItemLeftAction() {
        self.navigationEvent.send(.prev(nil))
    }
}
