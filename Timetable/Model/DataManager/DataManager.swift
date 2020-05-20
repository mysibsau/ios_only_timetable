//
//  DataManager.swift
//  Timetable
//
//  Created by art-off on 01.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation
import RealmSwift

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

// MARK: - Getting Entities
extension DataManager: GettingEntities {
    
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

// MARK: - Writing Entities
extension DataManager: WritingEntities {
    
    func writeFavorite(groups: [RGroup]) {
        // Если эти объекты уже будут в одном из хранилищь - так мы обезопасим себя от ошибки
        let copyGroups = groups.map { $0.newObject() }
        try? realmDocuments.write {
            realmDocuments.add(copyGroups, update: .modified)
        }
    }
    
    func writeFavorite(group: RGroup) {
        let copyGroup = group.newObject()
        try? realmDocuments.write {
            realmDocuments.add(copyGroup, update: .modified)
        }
    }
    
    func writeFavorite(professors: [RProfessor]) {
        let copyProfessors = professors.map { $0.newObject() }
        try? realmDocuments.write {
            realmDocuments.add(copyProfessors, update: .modified)
        }
    }
    
    func writeFavorite(professor: RProfessor) {
        let copyProfessor = professor.newObject()
        try? realmDocuments.write {
            realmDocuments.add(copyProfessor, update: .modified)
        }
    }
    
    func writeFavorite(places: [RPlace]) {
        let copyPlaces = places.map { $0.newObject() }
        try? realmDocuments.write {
            realmDocuments.add(copyPlaces, update: .modified)
        }
    }
    
    func writeFavorite(place: RPlace) {
        let copyPlace = place.newObject()
        try? realmDocuments.write {
            realmDocuments.add(copyPlace, update: .modified)
        }
    }
    
    func write(groups: [RGroup]) {
        let copyGroups = groups.map { $0.newObject() }
        try? realmCaches.write {
            realmCaches.add(copyGroups, update: .modified)
        }
    }
    
    func write(group: RGroup) {
        let copyGroup = group.newObject()
        try? realmCaches.write {
            realmCaches.add(copyGroup, update: .modified)
        }
    }
    
    func write(professors: [RProfessor]) {
        let copyProfessors = professors.map { $0.newObject() }
        try? realmCaches.write {
            realmCaches.add(copyProfessors, update: .modified)
        }
    }
    
    func write(professor: RProfessor) {
        let copyProfessor = professor.newObject()
        try? realmCaches.write {
            realmCaches.add(copyProfessor, update: .modified)
        }
    }
    
    func write(places: [RPlace]) {
        let copyPlaces = places.map { $0.newObject() }
        try? realmCaches.write {
            realmCaches.add(copyPlaces, update: .modified)
        }
    }
    
    func write(place: RPlace) {
        let copyPlace = place.newObject()
        try? realmCaches.write {
            realmCaches.add(copyPlace, update: .modified)
        }
    }

}

// MARK: - Deleting Entities
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

// MARK: - Getting Timetable
extension DataManager: GettingTimetable {
    
    func getTimetable(forGroupId groupId: Int) -> RGroupTimetable? {
        let timetables = realmDocuments.objects(RGroupTimetable.self).filter("groupId = \(groupId)")
        guard let timetable = timetables.first else { return nil }
        return timetable
    }
    
    func getTimetable(forProfessorId professorId: Int) -> RProfessorTimetable? {
        let timetables = realmDocuments.objects(RProfessorTimetable.self).filter("professorId = \(professorId)")
        guard let timetable = timetables.first else { return nil }
        return timetable
    }
    
    func getTimetable(forPlaceId placeId: Int) -> RPlaceTimetable? {
        let timetables = realmDocuments.objects(RPlaceTimetable.self).filter("placeId = \(placeId)")
        guard let timetable = timetables.first else { return nil }
        return timetable
    }
    
}
