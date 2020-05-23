//
//  GroupLesson.swift
//  Timetable
//
//  Created by art-off on 20.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

struct GroupSubgroup {
    
    let subject: String
    let type: String
    let professors: [String]
    let professorsId: [Int]
    let place: String
    //let placeId: Int?
    
}

struct GroupLesson {
    
    let time: String
    let subgroups: [GroupSubgroup]
    
}
