//
//  UserDefaultsConfig.swift
//  Timetable
//
//  Created by art-off on 20.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

struct UserDefaultsConfig {
    
    @UserDefaultsWrapper(key: "com.sibsu.user.timetableType", defaultValue: String?(nil))
    static var timetableType: String?
    
    @UserDefaultsWrapper(key: "com.sibsu.user.timetableId", defaultValue: Int?(nil))
    static var timetableId: Int?
    
    @UserDefaultsWrapper(key: "com.sibsu.system.firstWeekIsEven", defaultValue: false)
    static var firstWeekIsEven: Bool
    
    // MARK: Hash для определения версии таблиц
    @UserDefaultsWrapper(key: "com.sibsu.system.groupsHash", defaultValue: String?(nil))
    static var groupsHash: String?
    
    //@UserDefaultsWrapper(key: "com.sibsu.system.versionGroupsFromBundle", defaultValue: Int?(nil))
    //static var versionGroupsFromBundle: Int?
    
    //@UserDefaultsWrapper(key: "com.system.professorsHash", defaultValue: "")
    //static var professorsHash: String
    
    //@UserDefaultsWrapper(key: "com.system.placesHash", defaultValue: "")
    //static var placesHash: String
    
}
