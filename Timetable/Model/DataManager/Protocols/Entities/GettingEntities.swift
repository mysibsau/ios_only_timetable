//
//  GettingEntities.swift
//  Timetable
//
//  Created by art-off on 18.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import RealmSwift

protocol GettingEntities {
    
    func getGroups() -> Results<RGroup>
    //func getProfessors() -> Results<RProfessor>
    //func getPlaces() -> Results<RPlace>
    func getFavoriteGruops() -> Results<RGroup>
    //func getFavoriteProfessors() -> Results<RProfessor>
    //func getFavoritePlaces() -> Results<RPlace>
    
    func getGroup(withId id: Int) -> RGroup?
    //func getProfessor(withId id: Int) -> RProfessor?
    //func getPlace(withId id: Int) -> RPlace?
    
}
