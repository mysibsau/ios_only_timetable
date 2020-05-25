//
//  RGroup+newObject.swift
//  Timetable
//
//  Created by art-off on 17.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation
import RealmSwift

extension RGroup {
    
    func newObject() -> RGroup {
        let newGroup = RGroup()
        newGroup.id = id
        newGroup.name = name
        newGroup.email = email
        // newGroup.leaderName = leaderName
        // newGroup.leaderEmail = leaderEmail
        // newGroup.leaderPhone = leaderPhone
        
        return newGroup
    }
}

