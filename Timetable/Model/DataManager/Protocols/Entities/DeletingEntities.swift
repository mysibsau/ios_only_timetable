//
//  DeletingEntities.swift
//  Timetable
//
//  Created by art-off on 18.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import RealmSwift

protocol DeletingEntities {
    
    func deleteFavorite(groups: [RGroup])
    func deleteFavorite(group: RGroup)
    func deleteFavorite(professors: [RProfessor])
    func deleteFavorite(professor: RProfessor)
    func deleteFavorite(places: [RPlace])
    func deleteFavorite(place: RPlace)
    func delete(groups: [RGroup])
    func delete(group: RGroup)
    func delete(professors: [RProfessor])
    func delete(professor: RProfessor)
    func delete(places: [RPlace])
    func delete(place: RPlace)
    
}
