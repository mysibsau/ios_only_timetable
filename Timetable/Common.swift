//
//  Common.swift
//  Timetable
//
//  Created by art-off on 04.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

class Common {
    static func getDay1() -> GroupDay {
        let lesson1 = GroupLesson(
            time: "11:30 - 13:00",
            subgroups: [
                GroupSubgroup(subject: "Физическая культура что-то там еще", type: "(практика)", professors: ["Добрая бабуля", "Богданов Константив Васильевич(?)", "Охорзин Дед Почти", "Богданов Константив Васильевич(?)"], professorsId: [1, 2, 3, 4], place: "СПОРТЗАЛ")
            ]
        )
        
        let lesson2 = GroupLesson(
            time: "13:30 - 15:00",
            subgroups: [
                GroupSubgroup(subject: "Объектно-ориентированное программирование", type: "(лекция)", professors: ["Добрая бабуля"], professorsId: [1, 2, 3, 4], place: "Л 319"),
                GroupSubgroup(subject: "Ахритектура вычислительных систем", type: "(лекция)", professors: ["Богданов Константив Васильевич(?)"], professorsId: [1, 2, 3, 4], place: "Л 315")
            ]
        )
        
        let lesson3 = GroupLesson(
            time: "15:10 - 16:40",
            subgroups: [
                GroupSubgroup(subject: "Вычислительная математика", type: "(практика)", professors: ["Охорзин Дед Почти"], professorsId: [1, 2, 3, 4], place: "Н 304")
            ]
        )
        
        let lesson4 = GroupLesson(
            time: "16:50 - 18:20",
            subgroups: [
                GroupSubgroup(subject: "Вычислительная математика", type: "(практика)", professors: ["Охорзин Дед Почти"], professorsId: [1, 2, 3, 4], place: "Н 304")
            ]
        )
        
        let day = GroupDay(lessons: [lesson1, lesson2, lesson3, lesson4])
        return day
    }
    
    static func getDay2() -> GroupDay {
        let lesson1 = GroupLesson(
            time: "11:30 - 13:00",
            subgroups: [
                GroupSubgroup(subject: "Физическая культура что-то там еще", type: "(практика)", professors: ["Добрая бабуля", "Богданов Константив Васильевич(?)", "Охорзин Дед Почти", "Богданов Константив Васильевич(?)"], professorsId: [1, 2, 3, 4], place: "СПОРТЗАЛ")
            ]
        )
        
        let lesson4 = GroupLesson(
            time: "16:50 - 18:20",
            subgroups: [
                GroupSubgroup(subject: "Вычислительная математика", type: "(практика)", professors: ["Охорзин Дед Почти"], professorsId: [1, 2, 3, 4], place: "Н 304")
            ]
        )
        
        let day = GroupDay(lessons: [lesson1, lesson4])
        return day
    }
    
    static func getDay3() -> GroupDay {
        let lesson1 = GroupLesson(
            time: "33:33 - 33:00",
            subgroups: [
                GroupSubgroup(subject: "Физическая культура что-то там еще", type: "(практика)", professors: ["Добрая бабуля", "Богданов Константив Васильевич(?)", "Охорзин Дед Почти", "Богданов Константив Васильевич(?)"], professorsId: [1, 2, 3, 4], place: "СПОРТЗАЛ")
            ]
        )
        
        let lesson4 = GroupLesson(
            time: "16:33 - 18:33",
            subgroups: [
                GroupSubgroup(subject: "Вычислительная математика", type: "(практика)", professors: ["Охорзин Дед Почти"], professorsId: [1, 2, 3, 4], place: "Н 304")
            ]
        )
        
        let day = GroupDay(lessons: [lesson1, lesson4])
        return day
    }
    
    static func getWeek1() -> GroupWeek {
        let week = GroupWeek(days: [
            getDay1(), nil, nil, getDay2(), getDay3(), nil
        ])
        return week
    }
    
    static func getWeek2() -> GroupWeek {
        let week = GroupWeek(days: [
            nil, nil, getDay3(), getDay1(), getDay1(), nil
        ])
        return week
    }
    
    
    static func getGroupDay0() -> RGroupDay {
        
        let lesson1 = RGroupLesson()
        lesson1.time = "11:30 - 13:00"
        
        let subgroup11 = RGroupSubgroup()
        subgroup11.subject = "Физическая культура что-то там еще"
        subgroup11.type = "(практика)"
        subgroup11.professors.append(1)
        subgroup11.professors.append(2)
        subgroup11.professors.append(3)
        subgroup11.professors.append(4)
        subgroup11.place = "СПОРТЗАЛ"
        lesson1.subgroups.append(subgroup11)
        
        
        let lesson2 = RGroupLesson()
        lesson2.time = "13:30 - 15:00"
        
        let subgroup21 = RGroupSubgroup()
        subgroup21.subject = "Объектно-ориентированное программирование"
        subgroup21.type = "(лекция)"
        subgroup21.professors.append(5)
        subgroup21.place = "Л 319"
        lesson2.subgroups.append(subgroup21)
        let subgroup22 = RGroupSubgroup()
        subgroup22.subject = "Ахритектура вычислительных систем"
        subgroup22.type = "(лекция)"
        subgroup22.professors.append(7)
        subgroup22.place = "Л 315"
        
        
        let lesson3 = RGroupLesson()
        lesson3.time = "15:10 - 16:40"
        
        let subgroup31 = RGroupSubgroup()
        subgroup31.subject = "Вычислительная математика"
        subgroup31.type = "(практика)"
        subgroup31.professors.append(4)
        subgroup31.place = "Н 304"
        lesson3.subgroups.append(subgroup31)
        
        
        let lesson4 = RGroupLesson()
        lesson4.time = "15:10 - 16:40"
        
        let subgroup41 = RGroupSubgroup()
        subgroup41.subject = "Вычислительная математика"
        subgroup41.type = "(практика)"
        subgroup41.professors.append(4)
        subgroup41.place = "Н 304"
        lesson4.subgroups.append(subgroup41)

        
        let day = RGroupDay()
        day.number = 0
        day.lessons.append(lesson1)
        day.lessons.append(lesson2)
        day.lessons.append(lesson3)
        day.lessons.append(lesson4)
        return day
    }
    
    static func getGroupDay1() -> RGroupDay {
        
        let lesson1 = RGroupLesson()
        lesson1.time = "11:30 - 13:00"
        
        let subgroup11 = RGroupSubgroup()
        subgroup11.subject = "Физическая культура что-то там еще"
        subgroup11.type = "(практика)"
        subgroup11.professors.append(1)
        subgroup11.professors.append(2)
        subgroup11.place = "СПОРТЗАЛ"
        lesson1.subgroups.append(subgroup11)
        
        
        let lesson4 = RGroupLesson()
        lesson4.time = "15:10 - 16:40"
        
        let subgroup41 = RGroupSubgroup()
        subgroup41.subject = "Вычислительная математика"
        subgroup41.type = "(практика)"
        subgroup41.professors.append(4)
        subgroup41.place = "Н 304"
        lesson4.subgroups.append(subgroup41)
        
        
        let day = RGroupDay()
        day.number = 1
        day.lessons.append(lesson1)
        day.lessons.append(lesson4)
        return day
    }
    
    static func getGroupDay2() -> RGroupDay {
        
        let lesson1 = RGroupLesson()
        lesson1.time = "33:33 - 33:00"
        
        let subgroup11 = RGroupSubgroup()
        subgroup11.subject = "Физическая культура что-то там еще"
        subgroup11.type = "(практика)"
        subgroup11.professors.append(1)
        subgroup11.professors.append(2)
        subgroup11.place = "СПОРТЗАЛ"
        lesson1.subgroups.append(subgroup11)
        
        
        let lesson3 = RGroupLesson()
        lesson3.time = "15:10 - 16:40"
        
        let subgroup31 = RGroupSubgroup()
        subgroup31.subject = "Вычислительная математика"
        subgroup31.type = "(практика)"
        subgroup31.professors.append(4)
        subgroup31.place = "Н 304"
        lesson3.subgroups.append(subgroup31)
        
        
        let day = RGroupDay()
        day.number = 2
        day.lessons.append(lesson1)
        day.lessons.append(lesson3)
        return day
    }
    
    static func getGroupWeek1() -> RGroupWeek {
        let week = RGroupWeek()
        week.number = 0
        week.days.append(getGroupDay0())
        week.days.append(getGroupDay2())

        return week
    }
    
    static func getGroupWeek2() -> RGroupWeek {
        let week = RGroupWeek()
        week.number = 1
        week.days.append(getGroupDay1())
        week.days.append(getGroupDay2())

        return week
    }
    
    
    static func addGroupTimetable1() {
        
        let timetable = RGroupTimetable()
        timetable.groupId = 1

        timetable.weeks.append(getGroupWeek1())
        timetable.weeks.append(getGroupWeek2())
        
        DataManager.shared.write(groupTimetable: timetable)
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
