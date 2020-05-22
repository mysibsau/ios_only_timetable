//
//  RProfessor.swift
//  Timetable
//
//  Created by art-off on 28.04.2020.
//Copyright © 2020 art-off. All rights reserved.
//

import Foundation
import RealmSwift

class RProfessor: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var department: String? = nil
    @objc dynamic var email: String? = nil
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}
