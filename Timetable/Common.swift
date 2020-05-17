//
//  Common.swift
//  Timetable
//
//  Created by art-off on 04.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

class Common {
    static func getDay1() -> Day {
        let lesson1 = Lesson(
            time: "11:30 - 13:00",
            subgroups: [
                Subgroup(subject: "Физическая культура что-то там еще", type: "(практика)", professors: ["Добрая бабуля", "Богданов Константив Васильевич(?)", "Охорзин Дед Почти", "Богданов Константив Васильевич(?)"], place: "СПОРТЗАЛ")
            ]
        )
        
        let lesson2 = Lesson(
            time: "13:30 - 15:00",
            subgroups: [
                Subgroup(subject: "Объектно-ориентированное программирование", type: "(лекция)", professors: ["Добрая бабуля"], place: "Л 319"),
                Subgroup(subject: "Ахритектура вычислительных систем", type: "(лекция)", professors: ["Богданов Константив Васильевич(?)"], place: "Л 315")
            ]
        )
        
        let lesson3 = Lesson(
            time: "15:10 - 16:40",
            subgroups: [
                Subgroup(subject: "Вычислительная математика", type: "(практика)", professors: ["Охорзин Дед Почти"], place: "Н 304")
            ]
        )
        
        let lesson4 = Lesson(
            time: "16:50 - 18:20",
            subgroups: [
                Subgroup(subject: "Вычислительная математика", type: "(практика)", professors: ["Охорзин Дед Почти"], place: "Н 304")
            ]
        )
        
        let day = Day(lessons: [lesson1, lesson2, lesson3, lesson4])
        return day
    }
    
    static func getDay2() -> Day {
        let lesson1 = Lesson(
            time: "11:30 - 13:00",
            subgroups: [
                Subgroup(subject: "Физическая культура что-то там еще", type: "(практика)", professors: ["Добрая бабуля", "Богданов Константив Васильевич(?)", "Охорзин Дед Почти", "Богданов Константив Васильевич(?)"], place: "СПОРТЗАЛ")
            ]
        )
        
        let lesson4 = Lesson(
            time: "16:50 - 18:20",
            subgroups: [
                Subgroup(subject: "Вычислительная математика", type: "(практика)", professors: ["Охорзин Дед Почти"], place: "Н 304")
            ]
        )
        
        let day = Day(lessons: [lesson1, lesson4])
        return day
    }
    
    static func getDay3() -> Day {
        let lesson1 = Lesson(
            time: "33:33 - 33:00",
            subgroups: [
                Subgroup(subject: "Физическая культура что-то там еще", type: "(практика)", professors: ["Добрая бабуля", "Богданов Константив Васильевич(?)", "Охорзин Дед Почти", "Богданов Константив Васильевич(?)"], place: "СПОРТЗАЛ")
            ]
        )
        
        let lesson4 = Lesson(
            time: "16:33 - 18:33",
            subgroups: [
                Subgroup(subject: "Вычислительная математика", type: "(практика)", professors: ["Охорзин Дед Почти"], place: "Н 304")
            ]
        )
        
        let day = Day(lessons: [lesson1, lesson4])
        return day
    }
    
    static func getWeek1() -> Week {
        let week = Week(days: [
            getDay1(), nil, nil, getDay2(), getDay3(), nil
        ])
        return week
    }
    
    static func getWeek2() -> Week {
        let week = Week(days: [
            nil, nil, getDay3(), getDay1(), getDay1(), nil
        ])
        return week
    }
    
    static func addGroups() {
        
        var groups = [RGroup]()
        
        for i in 0...100 {
            let group = RGroup()
            group.id = i
            group.name = "\(i)name"
            group.email = "\(i)email"
            group.leaderName = "\(i)ln"
            group.leaderEmail = nil
            group.leaderPhone = "\(i)lp"
            
            groups.append(group)
        }
        
        DataManager.shared.write(groups: groups)
    }
    
    static func addProfessors() {
        
        var professors = [RProfessor]()
        
        for i in 0...100 {
            let professor = RProfessor()
            professor.id = i
            professor.name = "\(i)name"
            professor.email = "\(i)email"
            professor.department = "\(i)d"
            
            professors.append(professor)
        }
        
        DataManager.shared.write(professors: professors)
    }
    
    static func addPlaces() {
        
        var places = [RPlace]()
        
        for i in 0...100 {
            let place = RPlace()
            place.id = i
            place.name = "\(i)name"
            
            places.append(place)
        }
        
        DataManager.shared.write(places: places)
    }
    
    static func addFavoriteGroups() {
        
        var groups = [RGroup]()
        
        for i in [4, 20, 40, 94] {
            let group = RGroup()
            group.id = i
            group.name = "\(i)name"
            group.email = "\(i)email"
            group.leaderName = "\(i)ln"
            group.leaderEmail = nil
            group.leaderPhone = "\(i)lp"
            
            groups.append(group)
        }
        
        DataManager.shared.writeFavorite(groups: groups)
    }
    
}

//@objc dynamic var id = 0
//@objc dynamic var name = ""
//@objc dynamic var email: String? = nil
//// информация о старосте
//@objc dynamic var leaderName: String? = nil
//@objc dynamic var leaderEmail: String? = nil
//@objc dynamic var leaderPhone: String? = nil
//
//override class func primaryKey() -> String? {
//    return "id"
//}
