//
//  RProfessorTimetable.swift
//  Timetable
//
//  Created by art-off on 28.04.2020.
//Copyright © 2020 art-off. All rights reserved.
//

import Foundation
import RealmSwift

class RProfessorTimetable: Object {
    
    @objc dynamic var professorId = 0
    let weeks = List<RProfessorWeek>()
    
    override class func primaryKey() -> String? {
        return "professorId"
    }
    
}
