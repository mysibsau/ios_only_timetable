//
//  RProfessorDay.swift
//  Timetable
//
//  Created by art-off on 28.04.2020.
//Copyright © 2020 art-off. All rights reserved.
//

import Foundation
import RealmSwift

class RProfessorDay: Object {
    
    @objc dynamic var number = 0
    let lessons = List<RProfessorLesson>()
    
}
