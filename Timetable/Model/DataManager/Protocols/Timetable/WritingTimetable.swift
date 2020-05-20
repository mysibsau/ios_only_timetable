//
//  WritingTimetable.swift
//  Timetable
//
//  Created by art-off on 19.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import RealmSwift

protocol WritingTimetable {

    func write(groupTimetable: RGroupTimetable)
    func write(professorTimetable: RProfessorTimetable)
    func write(placeTimetable: RPlaceTimetable)
    
}
