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
    
    func showAlertWithAction(title: String, confirm: String, message: String, action: (() -> Void)?) {
        let viewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        viewController.addAction(UIAlertAction(title: scCancel, style: .default, handler: nil))
        viewController.addAction(UIAlertAction(title: confirm, style: .default) { _ in
            action?()
        })
        self.present(viewController, animated: true, completion: nil)
    }
    
    func checkInternetConnection(error: Error, action: (() -> Void)?) {
        if let errorType = (error as? ErrorType) {
            switch errorType {
            case .networkError(let error), .parsingError(let error):
                if (error as NSError).code != 6 && (error as NSError).code != -1009 {
                    showAlert(title: scError, message: errorType.localizedDescription)
                    return
                }
                showAlertWithAction(title: scError, confirm: scTryAgain, message: errorType.localizedDescription, action: action)
            case .dataNotFound:
                showAlert(title: scError, message: errorType.localizedDescription)
            }
        }
    }
}
