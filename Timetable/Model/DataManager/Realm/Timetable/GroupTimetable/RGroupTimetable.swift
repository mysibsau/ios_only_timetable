//
//  RGroupTimetable.swift
//  Timetable
//
//  Created by art-off on 28.04.2020.
//Copyright © 2020 art-off. All rights reserved.
//

import Foundation
import RealmSwift

class RGroupTimetable: Object, Decodable {
    
    @objc dynamic var groupId = 0
    let weeks = List<RGroupWeek>()
    
    override class func primaryKey() -> String? {
        return "groupId"
    }
    
}
