//
//  PlaceLesson.swift
//  Timetable
//
//  Created by art-off on 24.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

struct PlaceSubgroup {
    
    let number: Int
    let subject: String
    let type: String
    let groups: [String]
    let groupsId: [Int]
    let professors: [String]
    let professorsId: [Int]
    
}

struct PlaceLesson {
    
    let time: String
    let subgroups: [PlaceSubgroup]
    
}
