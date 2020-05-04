//
//  RProfessorConsultationDay.swift
//  Timetable
//
//  Created by art-off on 04.05.2020.
//Copyright © 2020 art-off. All rights reserved.
//

import Foundation
import RealmSwift

class RProfessorConsultationDay: Object {
    
    @objc dynamic var number = 0
    let lessons = List<RProfessorConsultation>()
    
}
