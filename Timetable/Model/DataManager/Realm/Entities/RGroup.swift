//
//  RGroup.swift
//  Timetable
//
//  Created by art-off on 28.04.2020.
//Copyright © 2020 art-off. All rights reserved.
//

import Foundation
import RealmSwift

class RGroup: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var email: String? = nil
    // информация о старосте
    @objc dynamic var leaderName: String? = nil
    @objc dynamic var leaderEmail: String? = nil
    @objc dynamic var leaderPhone: String? = nil
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}
