//
//  GettingSession.swift
//  Timetable
//
//  Created by art-off on 18.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import RealmSwift

protocol GettingSession {
    
    func getSession(forGroup group: Int)          // ->
    func getSession(forProfessor professor: Int)  // ->
    func getSession(forPlace place: Int)          // ->

}
