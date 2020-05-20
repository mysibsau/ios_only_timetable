//
//  WritingTimetable.swift
//  Timetable
//
//  Created by art-off on 19.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import RealmSwift

protocol WritingTimetable {

    func writeTimetable(forGroupId groupId: Int)
    func writeTimetable(forProfessorId professorId: Int)
    func writeTimetable(forPlaceId placeId: Int)
    
}
