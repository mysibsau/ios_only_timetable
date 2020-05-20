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
    
    func getGroup(withId id: Int) -> RGroup? {
        //let group = realmCaches.object(ofType: RGroup.self, forPrimaryKey: 1)
        let groups = realmCaches.objects(RGroup.self).filter("id = \(id)")
        guard let group = groups.first else { return nil }
        return group
    }
    
    func getProfessor(withId id: Int) -> RProfessor? {
        let professors = realmCaches.objects(RProfessor.self).filter("id = \(id)")
        guard let professor = professors.first else { return nil }
        return professor
    }
    
    func getPlace(withId id: Int) -> RPlace? {
        let places = realmCaches.objects(RPlace.self).filter("id = \(id)")
        guard let place = places.first else { return nil }
        return place
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
    
    func getTimetable(forGroupId groupId: Int) -> GroupTimetable? {
        let timetables = realmDocuments.objects(RGroupTimetable.self).filter("groupId = \(groupId)")
        guard let timetable = timetables.first else { return nil }
        
        let groupTimetable = getGroupTimetable(from: timetable)
        
        return groupTimetable
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

// MARK: - Writing Timetable
extension DataManager: WritingTimetable {
    
    func write(groupTimetable: RGroupTimetable) {
        try? realmDocuments.write {
            realmDocuments.add(groupTimetable, update: .modified)
        }
    }
    
    func write(professorTimetable: RProfessorTimetable) {
        try? realmDocuments.write {
            realmDocuments.add(professorTimetable, update: .modified)
        }
    }
    
    func write(placeTimetable: RPlaceTimetable) {
        try? realmDocuments.write {
            realmDocuments.add(placeTimetable, update: .modified)
        }
    }
    
}

// MARK: - Для перевода данных из классов Realm к структурам, используемых в приложении
extension DataManager {

    // MARK: Перевод объекта РАСПИСАНИЯ ГРУППЫ Realm к структуре, используемой в приложении
    private func getGroupTimetable(from timetable: RGroupTimetable) -> GroupTimetable {
        var groupWeeks = [GroupWeek]()

        // пробегаемся по всем неделям (по дву)
        for week in timetable.weeks {

            // заполняем массив дней nil, потом если будут учебные дни в этой недели - заменю значение
            var groupDays: [GroupDay?] = [nil, nil, nil, nil, nil, nil]

            // пробегаемся во всем дням недели
            for day in week.days {

                var groupLessons = [GroupLesson]()
                
                // пробегаемся по всем занятиям дня
                for lesson in day.lessons {

                    var groupSubgroups = [GroupSubgroup]()
                    
                    // пробегаемся по всех подргуппам занятия
                    for subgroup in lesson.subgroups {

                        var professorsName = [String]()
                        // берем имя преподавателя из БД с помощью id
                        for id in subgroup.professors {
                            let professor = getProfessor(withId: id)
                            if let professor = professor {
                                professorsName.append(professor.name)
                            } else {
                                professorsName.append("Ошибка")
                            }
                        }
                        
                        // копируем подргуппу
                        let groupSubgroup = GroupSubgroup(
                            subject: subgroup.subject,
                            type: subgroup.type,
                            professors: professorsName,
                            professorsId: Array(subgroup.professors),
                            place: subgroup.place)

                        groupSubgroups.append(groupSubgroup)
                    }
                    
                    // добавляем занятие в массив занятий
                    let groupLesson = GroupLesson(time: lesson.time, subgroups: groupSubgroups)
                    groupLessons.append(groupLesson)
                }
                
                let groupDay = GroupDay(lessons: groupLessons)
                // проверяем, подходит ли number для вставки в массив groupDays (0-понедельник, 5-суббота)
                if day.number >= 0 && day.number <= 5 {
                    // заменяем nil
                    groupDays[day.number] = groupDay
                }
            }

            let groupWeek = GroupWeek(days: groupDays)
            groupWeeks.append(groupWeek)
        }

        let groupTimetable = GroupTimetable(weeks: groupWeeks)
        return groupTimetable
    }
    
    // MARK: Перевод объекта РАСПИСАНИЯ ПРОФЕССОРА Realm к структуре, используемой в приложении
    
    // MARK: Перевод объекта РАСПИСАНИЯ КАБИНЕТА Realm к структуре, используемой в приложении

}
