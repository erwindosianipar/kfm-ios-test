//
//  UICollectionView+Helper.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 13/02/22.
//

import UIKit

extension UICollectionViewCell: Reusable {}

public extension UICollectionView {
    
    final func register<T: UICollectionViewCell>(cell: T.Type) {
        self.register(T.self, forCellWithReuseIdentifier: cell.identifier)
    }
    
    final func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, cell: T.Type = T.self) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: cell.identifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue cell with identifier \(cell.identifier) matching type \(cell.self)")
        }
        
        return cell
    }
}
