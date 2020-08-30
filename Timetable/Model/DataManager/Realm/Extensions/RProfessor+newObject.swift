//
//  RProfessor+newObject.swift
//  Timetable
//
//  Created by art-off on 17.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation
import RealmSwift

extension RProfessor {
    
    func newObject() -> RProfessor {
        let newProfessor = RProfessor()
        newProfessor.id = id
        newProfessor.name = name
        newProfessor.phone = phone
        newProfessor.email = email
        newProfessor.department = department
        
        return newProfessor
    }
}

