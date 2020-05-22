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
    
}
