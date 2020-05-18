//
//  GettingTimetable.swift
//  Timetable
//
//  Created by art-off on 18.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import RealmSwift

protocol GettingTimetable {
    
    func getTimetable(forGroup group: Int)          // ->
    func getTimetable(forProfessor professor: Int)  // ->
    func getTimetable(forPlace place: Int)          // ->
    
}
