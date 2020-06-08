//
//  RPlaceLesson.swift
//  Timetable
//
//  Created by art-off on 28.04.2020.
//Copyright © 2020 art-off. All rights reserved.
//

import Foundation
import RealmSwift

class RPlaceLesson: Object, Decodable {
    
    @objc dynamic var time = ""
    let subgroups = List<RPlaceSubgroup>()
    
    enum CodingKeys: String, CodingKey {
        case time
        case subgroups
    }
    
}

class RPlaceSubgroup: Object, Decodable {
    
    @objc dynamic var number = 0
    @objc dynamic var subject = ""
    @objc dynamic var type = 0
    let groups = List<Int>()
    let professors = List<Int>()
    
    enum CodingKeys: String, CodingKey {
        case number = "num"
        case subject
        case type
        case groups
        case professors
    }
    
}
