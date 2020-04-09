//
//  Lesson.swift
//  Timetable
//
//  Created by art-off on 07.04.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

struct Subgroup {
    let subject: String
    let type: String
    let professors: [String]
    let place: String
}

struct Lesson {
    
    let time: String
    let subgroups: [Subgroup]
    
}
