//
//  ProfessorLesson.swift
//  Timetable
//
//  Created by art-off on 24.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

struct ProfessorSubgroup {
    
    let subject: String
    let type: String
    let groups: [String]
    let groupsId: [Int]
    let place: String
    //let placeId: Int?
    
}

struct ProfessorLesson {
    
    let time: String
    let subgroups: [ProfessorSubgroup]
    
}
