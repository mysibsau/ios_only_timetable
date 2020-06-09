//
//  UserDefaultsConfig.swift
//  Timetable
//
//  Created by art-off on 20.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

struct UserDefaultsConfig {
    
    @UserDefaultsWrapper(key: "com.user.timetableType", defaultValue: String?(nil))
    static var timetableType: String?
    
    @UserDefaultsWrapper(key: "com.user.timetableId", defaultValue: Int?(nil))
    static var timetableId: Int?
    
    @UserDefaultsWrapper(key: "com.system.firstWeekIsEven", defaultValue: true)
    static var firstWeekIsEven: Bool
    
    // MARK: Hash для определения версии таблиц
    @UserDefaultsWrapper(key: "com.system.groupsHash", defaultValue: "")
    static var groupsHash: String
    
    @UserDefaultsWrapper(key: "com.system.professorsHash", defaultValue: "")
    static var professorsHash: String
    
    @UserDefaultsWrapper(key: "com.system.placesHash", defaultValue: "")
    static var placesHash: String
    
}
