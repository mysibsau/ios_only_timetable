//
//  RGroupLesson.swift
//  Timetable
//
//  Created by art-off on 28.04.2020.
//Copyright © 2020 art-off. All rights reserved.
//

import Foundation
import RealmSwift

class RGroupLesson: Object {
    
    @objc dynamic var time = ""
    let subgroups = List<RGroupSubgroup>()
    
}

class RGroupSubgroup: Object {
    
    @objc dynamic var subject = ""
    @objc dynamic var type = ""
    @objc dynamic var place = ""
    let professors = List<Int>()
    
}
