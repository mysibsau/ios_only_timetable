//
//  GettingConsultations.swift
//  Timetable
//
//  Created by art-off on 18.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import RealmSwift

protocol GettingConsultations {
    
    func getConsultations(forGroup group: Int)          // ->
    func getConsultations(forProfessor professor: Int)  // ->
    func getConsultations(forPlace place: Int)          // ->
    
}
