//
//  GettingTimetable.swift
//  Timetable
//
//  Created by art-off on 18.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import RealmSwift

protocol GettingTimetable {
    
    func getTimetable(forGroupId groupId: Int) -> GroupTimetable?
    func getTimetable(forProfessorId professorId: Int) -> RProfessorTimetable?
    func getTimetable(forPlaceId placeId: Int) -> RPlaceTimetable?
    
}
