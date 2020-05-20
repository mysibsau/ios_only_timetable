//
//  WritingSession.swift
//  Timetable
//
//  Created by art-off on 19.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import RealmSwift

protocol WritingSession {
    
    func writeSession(forGroup group: Int)
    func writeSession(forProfessor professor: Int)
    func writeSession(forPlace place: Int)
    
}
