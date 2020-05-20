//
//  UserDefaultsWrapper.swift
//  Timetable
//
//  Created by art-off on 20.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

private protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    
    var isNil: Bool { self == nil }
    
}

@propertyWrapper
struct UserDefaultsWrapper<T> {
    
    let key: String
    let defaultValue: T
    let userDefaults: UserDefaults = .standard
    
    var wrappedValue: T {
        get {
            return userDefaults.object(forKey: key) as? T ?? defaultValue
        }
        set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                //UserDefaults.standard.removeObject(forKey: key)
                userDefaults.removeObject(forKey: key)
            } else {
                userDefaults.set(newValue, forKey: key)
            }
        }
    }
    
}
