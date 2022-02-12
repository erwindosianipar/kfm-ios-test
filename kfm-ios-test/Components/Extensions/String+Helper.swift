//
//  String+Helper.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 13/02/22.
//

extension String {
    
    func removeWhiteSpace() -> String {
        return self.filter { !$0.isWhitespace }
    }
}
