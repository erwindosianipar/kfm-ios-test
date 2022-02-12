//
//  String.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 12/02/22.
//

extension String {
    
    func removeWhiteSpace() -> String {
        return self.filter { !$0.isWhitespace }
    }
}
