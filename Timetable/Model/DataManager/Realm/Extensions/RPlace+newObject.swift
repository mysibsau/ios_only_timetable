//
//  RPlace+newObject.swift
//  Timetable
//
//  Created by art-off on 17.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation
import RealmSwift

extension RPlace {
    
    func newObject() -> RPlace {
        let newPlace = RPlace()
        newPlace.id = id
        newPlace.name = name
        
        return newPlace
    }
}

