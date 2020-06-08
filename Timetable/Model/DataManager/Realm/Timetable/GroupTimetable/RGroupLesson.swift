//
//  RGroupLesson.swift
//  Timetable
//
//  Created by art-off on 28.04.2020.
//Copyright © 2020 art-off. All rights reserved.
//

import Foundation
import RealmSwift

class RGroupLesson: Object, Decodable {
    
    @objc dynamic var time = ""
    var subgroups = List<RGroupSubgroup>()
    
    enum CodingKeys: String, CodingKey {
        case time
        case subgroups
    }
    
}

class RGroupSubgroup: Object, Decodable {
    
    @objc dynamic var number = 0
    @objc dynamic var subject = ""
    @objc dynamic var type = 0
    @objc dynamic var place = 0
    var professors = List<Int>()
    
    enum CodingKeys: String, CodingKey {
        case number = "num"
        case subject
        case type
        case place
        case professors
    }
    
}
