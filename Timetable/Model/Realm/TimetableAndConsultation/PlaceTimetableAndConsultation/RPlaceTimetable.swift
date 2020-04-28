//
//  RPlaceTimetable.swift
//  Timetable
//
//  Created by art-off on 28.04.2020.
//Copyright © 2020 art-off. All rights reserved.
//

import Foundation
import RealmSwift

class RPlaceTimetable: Object {
    
    @objc dynamic var placeId = 0
    let weeks = List<RPlaceWeek>()
    
    override class func primaryKey() -> String? {
        return "placeId"
    }
    
}
