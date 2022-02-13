//
//  UICollectionViewFlowLayout+Helper.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 13/02/22.
//

import UIKit

enum UICollectionViewFlowLayoutRowType {
    case weather
    case log
}

extension CGSize {
    
    static var weatherItemSize: CGSize {
        let itemWidth = DeviceInformation.screenWidth / 3
        return CGSize(width: itemWidth, height: 165)
    }
    
    static var logItemSize: CGSize {
        let itemWidth = DeviceInformation.screenWidth / 6
        return CGSize(width: itemWidth, height: 100)
    }
}

extension UIEdgeInsets {
    
    static var defaultEdgeInset: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}

extension UICollectionViewFlowLayout {
    
    static func getLayout(type: UICollectionViewFlowLayoutRowType) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        switch type {
        case .weather:
            layout.itemSize = .weatherItemSize
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 10
            layout.sectionInset = .defaultEdgeInset
        case .log:
            layout.itemSize = .logItemSize
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 5
            layout.sectionInset = .defaultEdgeInset
        }
        
        return layout
    }
}
