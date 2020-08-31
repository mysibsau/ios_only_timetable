//
//  RGroupDay.swift
//  Timetable
//
//  Created by art-off on 28.04.2020.
//Copyright © 2020 art-off. All rights reserved.
//

import Foundation
import RealmSwift

class RGroupDay: Object {
    
    @objc dynamic var number = 0
    var lessons = List<RGroupLesson>()
    
//    enum CodingKeys: String, CodingKey {
//        case number = "day"
//        case lessons = "lesson"
//    }
    
}
