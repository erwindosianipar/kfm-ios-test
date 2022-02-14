//
//  AppDelegate.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 11/02/22.
//

import UIKit
import SnapKit
import netfox

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        NFX.sharedInstance().start()
        
        let appCoordinator = AppCoordinator(window: createWindow())
        appCoordinator.start()
        
        return true
    }
}
