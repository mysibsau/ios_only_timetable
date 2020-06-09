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
    private let downloadedRealm: Realm
    // данные пользователя
    private let userRealm: Realm
    
    init() {
        
        let fileManager = FileManager.default
        
        // создаем дирректорию для приложения в Documents
        let sibsuURL = try! fileManager
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("sibsu")
        
        if !fileManager.fileExists(atPath: sibsuURL.path) {
            do {
                try fileManager.createDirectory(at: sibsuURL, withIntermediateDirectories: true, attributes: nil)
            } catch {
                NSLog("Не выходит создать папку в Document директории")
            }
        }
        
        let downloadedURL = sibsuURL.appendingPathComponent("sibsu-downloaded.realm")
        let userURL = sibsuURL.appendingPathComponent("sibsu-user.realm")
        
        let downloadedConfig = Realm.Configuration(fileURL: downloadedURL)
        let userConfig = Realm.Configuration(fileURL: userURL)
        
        downloadedRealm = try! Realm(configuration: downloadedConfig)
        userRealm = try! Realm(configuration: userConfig)
        
        print(downloadedURL)
        print(userURL)
        
        deleteTimetable(forGroupId: 1)
    }
    
}

// MARK: - Getting Entities
extension DataManager: GettingEntities {
    
    func getProfessors() -> Results<RProfessor> {
        let professors = downloadedRealm.objects(RProfessor.self)
        return professors
    }
    
    func getGroups() -> Results<RGroup> {
        let groups = downloadedRealm.objects(RGroup.self)
        return groups
    }
    
    func getPlaces() -> Results<RPlace> {
        let places = downloadedRealm.objects(RPlace.self)
        return places
    }
    
    func getFavoriteProfessors() -> Results<RProfessor> {
        let professors = userRealm.objects(RProfessor.self)
        return professors
    }
    
    func getFavoriteGruops() -> Results<RGroup> {
        let groups = userRealm.objects(RGroup.self)
        return groups
    }
    
    func getFavoritePlaces() -> Results<RPlace> {
        let places = userRealm.objects(RPlace.self)
        return places
    }
    
    func getGroup(withId id: Int) -> RGroup? {
        let group = downloadedRealm.object(ofType: RGroup.self, forPrimaryKey: 1)
        //let groups = realmCaches.objects(RGroup.self).filter("id = \(id)")
        //guard let group = groups.first else { return nil }
        return group
    }
    
    func getProfessor(withId id: Int) -> RProfessor? {
        let professor = downloadedRealm.object(ofType: RProfessor.self, forPrimaryKey: id)
        //let professors = realmCaches.objects(RProfessor.self).filter("id = \(id)")
        //guard let professor = professors.first else { return nil }
        return professor
    }
    
    func getPlace(withId id: Int) -> RPlace? {
        let place = downloadedRealm.object(ofType: RPlace.self, forPrimaryKey: id)
        //let places = realmCaches.objects(RPlace.self).filter("id = \(id)")
        //guard let place = places.first else { return nil }
        return place
    }
    
}

// MARK: - Writing Entities
extension DataManager: WritingEntities {
    
    func writeFavorite(groups: [RGroup]) {
        // Если эти объекты уже будут в одном из хранилищь - так мы обезопасим себя от ошибки
        let copyGroups = groups.map { $0.newObject() }
        try? userRealm.write {
            userRealm.add(copyGroups, update: .modified)
        }
    }
    
    func writeFavorite(group: RGroup) {
        let copyGroup = group.newObject()
        try? userRealm.write {
            userRealm.add(copyGroup, update: .modified)
        }
    }
    
    func writeFavorite(professors: [RProfessor]) {
        let copyProfessors = professors.map { $0.newObject() }
        try? userRealm.write {
            userRealm.add(copyProfessors, update: .modified)
        }
    }
    
    func writeFavorite(professor: RProfessor) {
        let copyProfessor = professor.newObject()
        try? userRealm.write {
            userRealm.add(copyProfessor, update: .modified)
        }
    }
    
    func writeFavorite(places: [RPlace]) {
        let copyPlaces = places.map { $0.newObject() }
        try? userRealm.write {
            userRealm.add(copyPlaces, update: .modified)
        }
    }
    
    func writeFavorite(place: RPlace) {
        let copyPlace = place.newObject()
        try? userRealm.write {
            userRealm.add(copyPlace, update: .modified)
        }
    }
    
    func write(groups: [RGroup]) {
        let copyGroups = groups.map { $0.newObject() }
        try? downloadedRealm.write {
            downloadedRealm.add(copyGroups, update: .modified)
        }
    }
    
    func write(group: RGroup) {
        let copyGroup = group.newObject()
        try? downloadedRealm.write {
            downloadedRealm.add(copyGroup, update: .modified)
        }
    }
    
    func write(professors: [RProfessor]) {
        let copyProfessors = professors.map { $0.newObject() }
        try? downloadedRealm.write {
            downloadedRealm.add(copyProfessors, update: .modified)
        }
    }
    
    func write(professor: RProfessor) {
        let copyProfessor = professor.newObject()
        try? downloadedRealm.write {
            downloadedRealm.add(copyProfessor, update: .modified)
        }
    }
    
    func write(places: [RPlace]) {
        let copyPlaces = places.map { $0.newObject() }
        try? downloadedRealm.write {
            downloadedRealm.add(copyPlaces, update: .modified)
        }
    }
    
    func write(place: RPlace) {
        let copyPlace = place.newObject()
        try? downloadedRealm.write {
            downloadedRealm.add(copyPlace, update: .modified)
        }
    }

}

// MARK: - Deleting Entities
extension DataManager: DeletingEntities {
    
    func deleteFavorite(groups: [RGroup]) {
        try? userRealm.write {
            userRealm.delete(groups, cascading: true)
        }
    }
    
    func deleteFavorite(group: RGroup) {
        try? userRealm.write {
            userRealm.delete(group, cascading: true)
        }
    }
    
    func deleteFavorite(professors: [RProfessor]) {
        try? userRealm.write {
            userRealm.delete(professors, cascading: true)
        }
    }
    
    func deleteFavorite(professor: RProfessor) {
        try? userRealm.write {
            userRealm.delete(professor, cascading: true)
        }
    }
    
    func deleteFavorite(places: [RPlace]) {
        try? userRealm.write {
            userRealm.delete(places, cascading: true)
        }
    }
    
    func deleteFavorite(place: RPlace) {
        try? userRealm.write {
            userRealm.delete(place, cascading: true)
        }
    }
    
    func delete(groups: [RGroup]) {
        try? userRealm.write {
            userRealm.delete(groups, cascading: true)
        }
    }
    
    func delete(group: RGroup) {
        try? userRealm.write {
            userRealm.delete(group, cascading: true)
        }
    }
    
    func delete(professors: [RProfessor]) {
        try? userRealm.write {
            userRealm.delete(professors, cascading: true)
        }
    }
    
    func delete(professor: RProfessor) {
        try? userRealm.write {
            userRealm.delete(professor, cascading: true)
        }
    }
    
    func delete(places: [RPlace]) {
        try? userRealm.write {
            userRealm.delete(places, cascading: true)
        }
    }
    
    func delete(place: RPlace) {
        try? userRealm.write {
            userRealm.delete(place, cascading: true)
        }
    }
    
}

// MARK: - Getting Timetable
extension DataManager: GettingTimetable {
    
    func getTimetable(forGroupId groupId: Int) -> GroupTimetable? {
        let optionalTimetable = userRealm.object(ofType: RGroupTimetable.self, forPrimaryKey: groupId)
        let optionalGroup = downloadedRealm.object(ofType: RGroup.self, forPrimaryKey: groupId)
        guard let timetable = optionalTimetable else { return nil }
        guard let group = optionalGroup else { return nil }
        
        let groupTimetable = Converter.shared.convertGroupTimetable(from: timetable, groupName: group.name)
        
        return groupTimetable
    }
    
    func getTimetable(forProfessorId professorId: Int) -> ProfessorTimetable? {
        let optionalTimetable = userRealm.object(ofType: RProfessorTimetable.self, forPrimaryKey: professorId)
        let optionalProfessor = downloadedRealm.object(ofType: RProfessor.self, forPrimaryKey: professorId)
        guard let timetable = optionalTimetable else { return nil }
        guard let professor = optionalProfessor else { return nil }
        
        let profesorTimetable = Converter.shared.convertProfessorTimetable(from: timetable, professorName: professor.name)
        
        return profesorTimetable
    }
    
    func getTimetable(forPlaceId placeId: Int) -> PlaceTimetable? {
        let optionalTimetable = userRealm.object(ofType: RPlaceTimetable.self, forPrimaryKey: placeId)
        let optionalPlace = downloadedRealm.object(ofType: RPlace.self, forPrimaryKey: placeId)
        guard let timetable = optionalTimetable else { return nil }
        guard let place = optionalPlace else { return nil }
        
        let placeTimetable = Converter.shared.convertPlaceTimetable(from: timetable, placeName: place.name)
        
        return placeTimetable
    }
    
}

// MARK: - Writing Timetable
extension DataManager: WritingTimetable {
    
    func write(groupTimetable: RGroupTimetable) {
        try? userRealm.write {
            userRealm.add(groupTimetable, update: .modified)
        }
    }
    
    func write(professorTimetable: RProfessorTimetable) {
        try? userRealm.write {
            userRealm.add(professorTimetable, update: .modified)
        }
    }
    
    func write(placeTimetable: RPlaceTimetable) {
        try? userRealm.write {
            userRealm.add(placeTimetable, update: .modified)
        }
    }
    
}

// MARK: - Deleting Timetable
extension DataManager: DeletingTimetable {
    func deleteTimetable(forGroupId groupId: Int) {
        let optionalTimetable = userRealm.object(ofType: RGroupTimetable.self, forPrimaryKey: groupId)
        guard let timetable = optionalTimetable else { return }
        try? userRealm.write {
            userRealm.delete(timetable, cascading: true)
        }
    }
    
    func deleteTimetable(forProfessorId professorId: Int) {
        let optionalTimetable = userRealm.object(ofType: RProfessorTimetable.self, forPrimaryKey: professorId)
        guard let timetable = optionalTimetable else { return }
        try? userRealm.write {
            userRealm.delete(timetable, cascading: true)
        }
    }
    
    func deleteTimetable(forPlaceId placeId: Int) {
        let optionalTimetable = userRealm.object(ofType: RPlaceTimetable.self, forPrimaryKey: placeId)
        guard let timetable = optionalTimetable else { return }
        try? userRealm.write {
            userRealm.delete(timetable, cascading: true)
        }
    }
    
    
    
    
}
