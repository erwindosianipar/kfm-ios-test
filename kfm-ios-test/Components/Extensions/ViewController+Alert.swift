//
//  ViewController+Alert.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 13/02/22.
//

import UIKit

extension ViewController {
    
    func showAlert(title: String, message: String) {
        let viewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        viewController.addAction(UIAlertAction(title: scOk, style: .default, handler: nil))
        self.present(viewController, animated: true, completion: nil)
    }
}
