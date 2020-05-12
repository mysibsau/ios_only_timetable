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
    func getProfessors() -> Results<RProfessor>
    func getGroups() -> Results<RGroup>
    func getPlaces() -> Results<RPlace>
    func getSaveProfessors() -> Results<RProfessor>
    func getSaveGruops() -> Results<RGroup>
    func getSavePlaces() -> Results<RPlace>
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
    func writeSave(groups: [RGroup])
    func writeSave(professro: [RProfessor])
    func writeSave(places: [RPlace])
    func write(groups: [RGroup])
    func write(professors: [RProfessor])
    func write(places: [RPlace])
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
        
        // УДОЛИТЬ
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
    
    func getSaveProfessors() -> Results<RProfessor> {
        let professors = realmDocuments.objects(RProfessor.self)
        return professors
    }
    
    func getSaveGruops() -> Results<RGroup> {
        let groups = realmDocuments.objects(RGroup.self)
        return groups
    }
    
    func getSavePlaces() -> Results<RPlace> {
        let places = realmDocuments.objects(RPlace.self)
        return places
    }
    
}

extension DataManager: WritingEntities {
    
    func writeSave(groups: [RGroup]) {
        try? realmDocuments.write {
            realmDocuments.add(groups, update: .modified)
        }
    }
    
    func writeSave(professro: [RProfessor]) {
        try? realmDocuments.write {
            realmDocuments.add(professro, update: .modified)
        }
    }
    
    func writeSave(places: [RPlace]) {
        try? realmDocuments.write {
            realmDocuments.add(places, update: .modified)
        }
    }
    
    func write(groups: [RGroup]) {
        try? realmCaches.write {
            realmCaches.add(groups, update: .modified)
        }
    }
    
    func write(professors: [RProfessor]) {
        try? realmCaches.write {
            realmCaches.add(professors, update: .modified)
        }
    }
    
    func write(places: [RPlace]) {
        try? realmCaches.write {
            realmCaches.add(places, update: .modified)
        }
    }

}
