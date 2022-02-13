//
//  String+Helper.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 13/02/22.
//

import UIKit

enum WeatherWrapperString {
    case wrap(String, String)
    case first(String)
    case last(String)
    case separate(String)
}

extension Date {
    
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}

extension String {
    
    func addWrapper(wrapper: WeatherWrapperString) -> String {
        switch wrapper {
        case .wrap(let first, let last):
            return "\(first) \(self)\(last)"
        case .first(let first):
            return "\(first) \(self)"
        case .last(let last):
            return self + last
        case .separate(let value):
            return "\(self) — \(value)"
        }
    }
    
    func dateFormat(from: String, to: String) -> String {
        let formatFrom = DateFormatter()
        formatFrom.dateFormat = from
        
        let formatTo = DateFormatter()
        formatTo.dateFormat = to
        
        if let date = formatFrom.date(from: self) {
            let calendar = Calendar.current
            if calendar.component(.day, from: Date()) == calendar.component(.day, from: date) {
                return scToday
            }
            
            return formatTo.string(from: date)
        }
        
        return self
    }
}
