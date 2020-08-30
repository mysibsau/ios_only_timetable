//
//  WritingEntities.swift
//  Timetable
//
//  Created by art-off on 18.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import RealmSwift

protocol WritingEntities {
    
    func writeFavorite(groups: [RGroup])
    func writeFavorite(group: RGroup)
    //func writeFavorite(professors: [RProfessor])
    //func writeFavorite(professor: RProfessor)
    //func writeFavorite(places: [RPlace])
    //func writeFavorite(place: RPlace)
    func write(groups: [RGroup])
    func write(group: RGroup)
    //func write(professors: [RProfessor])
    //func write(professor: RProfessor)
    //func write(places: [RPlace])
    //func write(place: RPlace)
    
}
