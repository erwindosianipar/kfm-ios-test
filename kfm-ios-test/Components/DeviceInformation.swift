//
//  DeviceInformation.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 13/02/22.
//

import UIKit

internal final class DeviceInformation {
    
    static var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
}
