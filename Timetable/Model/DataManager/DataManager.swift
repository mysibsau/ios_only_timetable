//
//  DataManager.swift
//  Timetable
//
//  Created by art-off on 01.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation
import RealmSwift

//
// поменять названия протоколов
//

protocol GetingEntities {
    func getGroups() -> Results<RGroup>
    func getProfessors() -> Results<RProfessor>
    func getPlaces() -> Results<RPlace>
    func getFavoriteGruops() -> Results<RGroup>
    func getFavoriteProfessors() -> Results<RProfessor>
    func getFavoritePlaces() -> Results<RPlace>
}

protocol GettingTimetable {
    func getTimetable(forGroup group: Int)          // ->
    func getTimetable(forProfessor professor: Int)  // ->
    func getTimetable(forPlace place: Int)          // ->
}

protocol GettingConsultations {
    func getConsultations(forGroup group: Int)          // ->
    func getConsultations(forProfessor professor: Int)  // ->
    func getConsultations(forPlace place: Int)          // ->
}

protocol GettingSession {
    func getSession(forGroup group: Int)          // ->
    func getSession(forProfessor professor: Int)  // ->
    func getSession(forPlace place: Int)          // ->
}

protocol WritingEntities {
    func writeFavorite(groups: [RGroup])
    func writeFavorite(group: RGroup)
    func writeFavorite(professors: [RProfessor])
    func writeFavorite(professor: RProfessor)
    func writeFavorite(places: [RPlace])
    func writeFavorite(place: RPlace)
    func write(groups: [RGroup])
    func write(group: RGroup)
    func write(professors: [RProfessor])
    func write(professor: RProfessor)
    func write(places: [RPlace])
    func write(place: RPlace)
}

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


class DataManager {
    
    static let shared = DataManager()
    
    // загруженные данные
    private let realmCaches: Realm
    // данные пользователя
    private let realmDocuments: Realm
    
    init() {
        let cachesURL = try! FileManager.default
            .url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("sibsu.realm")
        let documentsURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("sibsu.realm")
        
        let cachesConfig = Realm.Configuration(fileURL: cachesURL)
        let documentsConfig = Realm.Configuration(fileURL: documentsURL)
        
        realmCaches = try! Realm(configuration: cachesConfig)
        realmDocuments = try! Realm(configuration: documentsConfig)
        
        print(cachesURL)
        print(documentsURL)
    }
    
}


extension DataManager: GetingEntities {
    
    func getProfessors() -> Results<RProfessor> {
        let professors = realmCaches.objects(RProfessor.self)
        return professors
    }
    
    func getGroups() -> Results<RGroup> {
        let groups = realmCaches.objects(RGroup.self)
        return groups
    }
    
    func getPlaces() -> Results<RPlace> {
        let places = realmCaches.objects(RPlace.self)
        return places
    }
    
    func getFavoriteProfessors() -> Results<RProfessor> {
        let professors = realmDocuments.objects(RProfessor.self)
        return professors
    }
    
    func getFavoriteGruops() -> Results<RGroup> {
        let groups = realmDocuments.objects(RGroup.self)
        return groups
    }
    
    func getFavoritePlaces() -> Results<RPlace> {
        let places = realmDocuments.objects(RPlace.self)
        return places
    }
    
}

extension DataManager: WritingEntities {
    
    func writeFavorite(groups: [RGroup]) {
        try? realmDocuments.write {
            realmDocuments.add(groups, update: .modified)
        }
    }
    
    func writeFavorite(group: RGroup) {
        try? realmDocuments.write {
            realmDocuments.add(group, update: .modified)
        }
    }
    
    func writeFavorite(professors: [RProfessor]) {
        try? realmDocuments.write {
            realmDocuments.add(professors, update: .modified)
        }
    }
    
    func writeFavorite(professor: RProfessor) {
        try? realmDocuments.write {
            realmDocuments.add(professor, update: .modified)
        }
    }
    
    func writeFavorite(places: [RPlace]) {
        try? realmDocuments.write {
            realmDocuments.add(places, update: .modified)
        }
    }
    
    func writeFavorite(place: RPlace) {
        try? realmDocuments.write {
            realmDocuments.add(place, update: .modified)
        }
    }
    
    func write(groups: [RGroup]) {
        try? realmCaches.write {
            realmCaches.add(groups, update: .modified)
        }
    }
    
    func write(group: RGroup) {
        try? realmCaches.write {
            realmCaches.add(group, update: .modified)
        }
    }
    
    func write(professors: [RProfessor]) {
        try? realmCaches.write {
            realmCaches.add(professors, update: .modified)
        }
    }
    
    func write(professor: RProfessor) {
        try? realmCaches.write {
            realmCaches.add(professor, update: .modified)
        }
    }
    
    func write(places: [RPlace]) {
        try? realmCaches.write {
            realmCaches.add(places, update: .modified)
        }
    }
    
    func write(place: RPlace) {
        try? realmCaches.write {
            realmCaches.add(place, update: .modified)
        }
    }

}

extension DataManager: DeletingEntities {
    
    func deleteFavorite(groups: [RGroup]) {
        try? realmDocuments.write {
            realmDocuments.delete(groups)
        }
    }
    
    func deleteFavorite(group: RGroup) {
        try? realmDocuments.write {
            realmDocuments.delete(group)
        }
    }
    
    func deleteFavorite(professors: [RProfessor]) {
        try? realmDocuments.write {
            realmDocuments.delete(professors)
        }
    }
    
    func deleteFavorite(professor: RProfessor) {
        try? realmDocuments.write {
            realmDocuments.delete(professor)
        }
    }
    
    func deleteFavorite(places: [RPlace]) {
        try? realmDocuments.write {
            realmDocuments.delete(places)
        }
    }
    
    func deleteFavorite(place: RPlace) {
        try? realmDocuments.write {
            realmDocuments.delete(place)
        }
    }
    
    func delete(groups: [RGroup]) {
        try? realmDocuments.write {
            realmDocuments.delete(groups)
        }
    }
    
    func delete(group: RGroup) {
        try? realmDocuments.write {
            realmDocuments.delete(group)
        }
    }
    
    func delete(professors: [RProfessor]) {
        try? realmDocuments.write {
            realmDocuments.delete(professors)
        }
    }
    
    func delete(professor: RProfessor) {
        try? realmDocuments.write {
            realmDocuments.delete(professor)
        }
    }
    
    func delete(places: [RPlace]) {
        try? realmDocuments.write {
            realmDocuments.delete(places)
        }
    }
    
    func delete(place: RPlace) {
        try? realmDocuments.write {
            realmDocuments.delete(place)
        }
    }
    
}
