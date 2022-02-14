//
//  UserDefaultConfig.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 14/02/22.
//

import Foundation

@propertyWrapper
struct UserDefault<T: Codable> {
    
    let key: String
    let value: T
    
    init(key: String, value: T) {
        self.key = key
        self.value = value
    }
    
    var wrappedValue: T {
        get {
            if let data = UserDefaults.standard.object(forKey: key) as? Data,
               let object = try? JSONDecoder().decode(T.self, from: data) {
                return object
            }
            
            return value
        }
        
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
        }
    }
}

internal struct UserDefaultConfig {
    
    @UserDefault(key: "locationData", value: [])
    static var locationData: [HomeScreenResultModel]
}
