//
//  Common.swift
//  Timetable
//
//  Created by art-off on 04.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

class Common {
//    static func getDay1() -> GroupDay {
//        let lesson1 = GroupLesson(
//            time: "11:30 - 13:00",
//            subgroups: [
//                GroupSubgroup(subject: "Физическая культура что-то там еще", type: "(практика)", professors: ["Добрая бабуля", "Богданов Константив Васильевич(?)", "Охорзин Дед Почти", "Богданов Константив Васильевич(?)"], professorsId: [1, 2, 3, 4], place: "СПОРТЗАЛ")
//            ]
//        )
//
//        let lesson2 = GroupLesson(
//            time: "13:30 - 15:00",
//            subgroups: [
//                GroupSubgroup(subject: "Объектно-ориентированное программирование", type: "(лекция)", professors: ["Добрая бабуля"], professorsId: [1, 2, 3, 4], place: "Л 319"),
//                GroupSubgroup(subject: "Ахритектура вычислительных систем", type: "(лекция)", professors: ["Богданов Константив Васильевич(?)"], professorsId: [1, 2, 3, 4], place: "Л 315")
//            ]
//        )
//
//        let lesson3 = GroupLesson(
//            time: "15:10 - 16:40",
//            subgroups: [
//                GroupSubgroup(subject: "Вычислительная математика", type: "(практика)", professors: ["Охорзин Дед Почти"], professorsId: [1, 2, 3, 4], place: "Н 304")
//            ]
//        )
//
//        let lesson4 = GroupLesson(
//            time: "16:50 - 18:20",
//            subgroups: [
//                GroupSubgroup(subject: "Вычислительная математика", type: "(практика)", professors: ["Охорзин Дед Почти"], professorsId: [1, 2, 3, 4], place: "Н 304")
//            ]
//        )
//
//        let day = GroupDay(lessons: [lesson1, lesson2, lesson3, lesson4])
//        return day
//    }
//
//    static func getDay2() -> GroupDay {
//        let lesson1 = GroupLesson(
//            time: "11:30 - 13:00",
//            subgroups: [
//                GroupSubgroup(subject: "Физическая культура что-то там еще", type: "(практика)", professors: ["Добрая бабуля", "Богданов Константив Васильевич(?)", "Охорзин Дед Почти", "Богданов Константив Васильевич(?)"], professorsId: [1, 2, 3, 4], place: "СПОРТЗАЛ")
//            ]
//        )
//
//        let lesson4 = GroupLesson(
//            time: "16:50 - 18:20",
//            subgroups: [
//                GroupSubgroup(subject: "Вычислительная математика", type: "(практика)", professors: ["Охорзин Дед Почти"], professorsId: [1, 2, 3, 4], place: "Н 304")
//            ]
//        )
//
//        let day = GroupDay(lessons: [lesson1, lesson4])
//        return day
//    }
//
//    static func getDay3() -> GroupDay {
//        let lesson1 = GroupLesson(
//            time: "33:33 - 33:00",
//            subgroups: [
//                GroupSubgroup(subject: "Физическая культура что-то там еще", type: "(практика)", professors: ["Добрая бабуля", "Богданов Константив Васильевич(?)", "Охорзин Дед Почти", "Богданов Константив Васильевич(?)"], professorsId: [1, 2, 3, 4], place: "СПОРТЗАЛ")
//            ]
//        )
//
//        let lesson4 = GroupLesson(
//            time: "16:33 - 18:33",
//            subgroups: [
//                GroupSubgroup(subject: "Вычислительная математика", type: "(практика)", professors: ["Охорзин Дед Почти"], professorsId: [1, 2, 3, 4], place: "Н 304")
//            ]
//        )
//
//        let day = GroupDay(lessons: [lesson1, lesson4])
//        return day
//    }
//
//    static func getWeek1() -> GroupWeek {
//        let week = GroupWeek(days: [
//            getDay1(), nil, nil, getDay2(), getDay3(), nil
//        ])
//        return week
//    }
//
//    static func getWeek2() -> GroupWeek {
//        let week = GroupWeek(days: [
//            nil, nil, getDay3(), getDay1(), getDay1(), nil
//        ])
//        return week
//    }
    
    
    static func getGroupDay0() -> RGroupDay {
        
        let lesson1 = RGroupLesson()
        lesson1.time = "11:30 - 13:00"
        
        let subgroup11 = RGroupSubgroup()
        subgroup11.number = 0
        subgroup11.subject = "Физическая культура что-то там еще"
        subgroup11.type = 0
        subgroup11.professors.append(1)
        subgroup11.professors.append(2)
        subgroup11.professors.append(3)
        subgroup11.professors.append(4)
        subgroup11.place = 3
        lesson1.subgroups.append(subgroup11)
        
        
        let lesson2 = RGroupLesson()
        lesson2.time = "13:30 - 15:00"
        
        let subgroup21 = RGroupSubgroup()
        subgroup21.number = 1
        subgroup21.subject = "Объектно-ориентированное программирование"
        subgroup21.type = 1
        subgroup21.professors.append(5)
        subgroup21.place = 43
        lesson2.subgroups.append(subgroup21)
        let subgroup22 = RGroupSubgroup()
        subgroup22.number = 2
        subgroup22.subject = "Ахритектура вычислительных систем"
        subgroup22.type = 1
        subgroup22.professors.append(7)
        subgroup22.place = 54
        lesson2.subgroups.append(subgroup22)
        
        let lesson3 = RGroupLesson()
        lesson3.time = "14:99 - 23:32"
        
        let subgroup31 = RGroupSubgroup()
        subgroup31.number = 0
        subgroup31.subject = "Вычислительная математика"
        subgroup31.type = 0
        subgroup31.professors.append(4)
        subgroup31.place = 38
        lesson3.subgroups.append(subgroup31)
        
        
        let lesson4 = RGroupLesson()
        lesson4.time = "15:10 - 16:40"
        
        let subgroup41 = RGroupSubgroup()
        subgroup41.number = 0
        subgroup41.subject = "Вычислительная математика"
        subgroup41.type = 1
        subgroup41.professors.append(4)
        subgroup41.place = 90
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
        subgroup11.number = 0
        subgroup11.subject = "Физическая культура что-то там еще"
        subgroup11.type = 0
        subgroup11.professors.append(1)
        subgroup11.professors.append(2)
        subgroup11.place = 22
        lesson1.subgroups.append(subgroup11)
        
        
        let lesson4 = RGroupLesson()
        lesson4.time = "15:10 - 16:40"
        
        let subgroup41 = RGroupSubgroup()
        subgroup41.number = 0
        subgroup41.subject = "Вычислительная математика"
        subgroup41.type = 2
        subgroup41.professors.append(4)
        subgroup41.place = 33
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
        subgroup11.number = 0
        subgroup11.subject = "Физическая культура что-то там еще"
        subgroup11.type = 1
        subgroup11.professors.append(1)
        subgroup11.professors.append(2)
        subgroup11.place = 3
        lesson1.subgroups.append(subgroup11)
        
        
        let lesson3 = RGroupLesson()
        lesson3.time = "15:10 - 16:40"
        
        let subgroup31 = RGroupSubgroup()
        subgroup31.number = 0
        subgroup31.subject = "Вычислительная математика"
        subgroup31.type = 1
        subgroup31.professors.append(4)
        subgroup31.place = 2
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
    
    static func getGroupWeek3() -> RGroupWeek {
        let week = RGroupWeek()
        week.number = 1
        week.days.append(getGroupDay0())
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
    
    static func addGroupTimetable5() {
        let timetable = RGroupTimetable()
        timetable.groupId = 5

        timetable.weeks.append(getGroupWeek1())
        timetable.weeks.append(getGroupWeek3())
        
        DataManager.shared.write(groupTimetable: timetable)
    }
    
    
    
    static func addGroups() {
        
        var groups = [RGroup]()
        
        for i in 0...100 {
            let group = RGroup()
            group.id = i
            group.name = "\(i)nameGroup"
            group.email = "\(i)emailGroup"
            // group.leaderName = "\(i)lnGroup"
            // group.leaderEmail = nil
            // group.leaderPhone = "\(i)lpGroup"
            
            groups.append(group)
        }
        
        DataManager.shared.write(groups: groups)
    }
    
    static func addProfessors() {
        
        var professors = [RProfessor]()
        
        for i in 0...100 {
            let professor = RProfessor()
            professor.id = i
            professor.name = "\(i)nameProfessor"
            professor.email = "\(i)emailProfessor"
            //professor.phone = nil
            professor.department = "\(i)dProfessor"
            
            professors.append(professor)
        }
        
        DataManager.shared.write(professors: professors)
    }
    
    static func addPlaces() {
        
        var places = [RPlace]()
        
        for i in 0...100 {
            let place = RPlace()
            place.id = i
            place.name = "\(i)namePlace"
            
            places.append(place)
        }
        
        DataManager.shared.write(places: places)
    }
    
//    static func addFavoriteGroups() {
//
//        var groups = [RGroup]()
//
//        for i in [4, 20, 40, 94] {
//            let group = RGroup()
//            group.id = i
//            group.name = "\(i)nameGroup"
//            group.email = "\(i)emailGroup"
//            // group.leaderName = "\(i)lnGroup"
//            // group.leaderEmail = nil
//            // group.leaderPhone = "\(i)lpGroup"
//
//            groups.append(group)
//        }
//
//        DataManager.shared.writeFavorite(groups: groups)
//    }
    
    
    
    // MARK: - Расписание преопдавателей
    static func getProfessorDay0() -> RProfessorDay {
        
        let lesson1 = RProfessorLesson()
        lesson1.time = "11:30 - 13:00"
        
        let subgroup11 = RProfessorSubgroup()
        subgroup11.number = 1
        subgroup11.subject = "Не физ культура"
        subgroup11.type = 1
        subgroup11.groups.append(1)
        subgroup11.groups.append(2)
        subgroup11.place = 111
        lesson1.subgroups.append(subgroup11)
        
        let subgroup12 = RProfessorSubgroup()
        subgroup12.number = 2
        subgroup12.subject = "из культура"
        subgroup12.type = 1
        subgroup12.groups.append(1)
        subgroup12.groups.append(2)
        subgroup12.place = 32
        lesson1.subgroups.append(subgroup12)
        
        
        let lesson2 = RProfessorLesson()
        lesson2.time = "13:30 - 15:00"
        
        let subgroup21 = RProfessorSubgroup()
        subgroup21.number = 1
        subgroup21.subject = "Архитектура"
        subgroup21.type = 1
        subgroup21.groups.append(5)
        subgroup21.place = 4
        lesson2.subgroups.append(subgroup21)
        let subgroup22 = RProfessorSubgroup()
        subgroup22.number = 2
        subgroup22.subject = "Ахритектура вычислительных систем"
        subgroup22.type = 1
        subgroup22.groups.append(7)
        subgroup22.place = 24
        lesson2.subgroups.append(subgroup22)
        
        
        let lesson3 = RProfessorLesson()
        lesson3.time = "15:10 - 16:40"
        
        let subgroup31 = RProfessorSubgroup()
        subgroup31.number = 0
        subgroup31.subject = "Матааан"
        subgroup31.type = 1
        subgroup31.groups.append(4)
        subgroup31.place = 999
        lesson3.subgroups.append(subgroup31)
        
        
        let lesson4 = RProfessorLesson()
        lesson4.time = "15:10 - 16:40"
        
        let subgroup41 = RProfessorSubgroup()
        subgroup41.number = 0
        subgroup41.subject = "Вычислительная математика"
        subgroup41.type = 1
        subgroup41.groups.append(4)
        subgroup41.place = 32
        lesson4.subgroups.append(subgroup41)

        
        let day = RProfessorDay()
        day.number = 0
        day.lessons.append(lesson1)
        day.lessons.append(lesson2)
        day.lessons.append(lesson3)
        day.lessons.append(lesson4)
        return day
    }
    
    static func getProfessorDay1() -> RProfessorDay {
        
        let lesson1 = RProfessorLesson()
        lesson1.time = "11:30 - 13:00"
        
        let subgroup11 = RProfessorSubgroup()
        subgroup11.number = 0
        subgroup11.subject = "Физическая культура что-то там еще"
        subgroup11.type = 1
        subgroup11.groups.append(1)
        subgroup11.groups.append(2)
        subgroup11.place = 12
        lesson1.subgroups.append(subgroup11)
        
        
        let lesson4 = RProfessorLesson()
        lesson4.time = "15:10 - 16:40"
        
        let subgroup41 = RProfessorSubgroup()
        subgroup41.number = 0
        subgroup41.subject = "Вычислительная математика"
        subgroup41.type = 1
        subgroup41.groups.append(4)
        subgroup41.place = 32
        lesson4.subgroups.append(subgroup41)
        
        
        let day = RProfessorDay()
        day.number = 1
        day.lessons.append(lesson1)
        day.lessons.append(lesson4)
        return day
    }
    
    static func getProfessorDay5() -> RProfessorDay {
        
        let lesson1 = RProfessorLesson()
        lesson1.time = "33:33 - 33:00"
        
        let subgroup11 = RProfessorSubgroup()
        subgroup11.number = 0
        subgroup11.subject = "sdsdsdsd"
        subgroup11.type = 2
        subgroup11.groups.append(1)
        subgroup11.groups.append(2)
        subgroup11.place = 43
        lesson1.subgroups.append(subgroup11)
        
        
        let lesson3 = RProfessorLesson()
        lesson3.time = "15:10 - 16:40"
        
        let subgroup31 = RProfessorSubgroup()
        subgroup31.number = 0
        subgroup31.subject = "ffffff"
        subgroup31.type = 2
        subgroup31.groups.append(4)
        subgroup31.place = 55
        lesson3.subgroups.append(subgroup31)
        
        
        let day = RProfessorDay()
        day.number = 5
        day.lessons.append(lesson1)
        day.lessons.append(lesson3)
        return day
    }
    
    static func getProfessorWeek1() -> RProfessorWeek {
        let week = RProfessorWeek()
        week.number = 0
        week.days.append(getProfessorDay0())

        return week
    }
    
    static func getProfessorWeek2() -> RProfessorWeek {
        let week = RProfessorWeek()
        week.number = 1
        week.days.append(getProfessorDay0())
        week.days.append(getProfessorDay1())
        week.days.append(getProfessorDay5())

        return week
    }
    
    static func getProfessorWeek3() -> RProfessorWeek {
        let week = RProfessorWeek()
        week.number = 1
        week.days.append(getProfessorDay1())

        return week
    }
    
    
    static func addProfessorTimetable1() {
        
        let timetable = RProfessorTimetable()
        timetable.professorId = 10

        timetable.weeks.append(getProfessorWeek1())
        timetable.weeks.append(getProfessorWeek2())
        
        DataManager.shared.write(professorTimetable: timetable)
    }
    
    static func addProfessorTimetable5() {
        let timetable = RProfessorTimetable()
        timetable.professorId = 5

        timetable.weeks.append(getProfessorWeek1())
        timetable.weeks.append(getProfessorWeek3())
        
        DataManager.shared.write(professorTimetable: timetable)
    }
    
    // MARK: - Расписание для кабинетов
    static func getPlaceDay2() -> RPlaceDay {
        
        let lesson1 = RPlaceLesson()
        lesson1.time = "11:30 - 13:00"
        
        let subgroup11 = RPlaceSubgroup()
        subgroup11.number = 1
        subgroup11.subject = "Не физ культура"
        subgroup11.type = 1
        subgroup11.groups.append(1)
        subgroup11.groups.append(2)
        subgroup11.professors.append(5)
        subgroup11.professors.append(101)
        lesson1.subgroups.append(subgroup11)
        
        let subgroup12 = RPlaceSubgroup()
        subgroup12.number = 2
        subgroup12.subject = "из культура"
        subgroup12.type = 1
        subgroup12.groups.append(1)
        subgroup12.groups.append(2)
        subgroup12.professors.append(4)
        subgroup12.professors.append(5)
        lesson1.subgroups.append(subgroup12)
        
        
        let lesson2 = RPlaceLesson()
        lesson2.time = "13:30 - 15:00"
        
        let subgroup21 = RPlaceSubgroup()
        subgroup21.number = 1
        subgroup21.subject = "Архитектура"
        subgroup21.type = 0
        subgroup21.groups.append(5)
        subgroup21.professors.append(9)
        lesson2.subgroups.append(subgroup21)
        let subgroup22 = RPlaceSubgroup()
        subgroup22.number = 2
        subgroup22.subject = "Ахритектура вычислительных систем"
        subgroup22.type = 0
        subgroup22.groups.append(7)
        subgroup22.professors.append(7)
        lesson2.subgroups.append(subgroup22)
        
        
        let lesson3 = RPlaceLesson()
        lesson3.time = "15:10 - 16:40"
        
        let subgroup31 = RPlaceSubgroup()
        subgroup31.number = 0
        subgroup31.subject = "Матааан"
        subgroup31.type = 0
        subgroup31.groups.append(4)
        subgroup31.professors.append(14)
        lesson3.subgroups.append(subgroup31)
        
        
        let lesson4 = RPlaceLesson()
        lesson4.time = "15:10 - 16:40"
        
        let subgroup41 = RPlaceSubgroup()
        subgroup41.number = 0
        subgroup41.subject = "Вычислительная математика"
        subgroup41.type = 0
        subgroup41.groups.append(4)
        subgroup41.professors.append(66)
        lesson4.subgroups.append(subgroup41)

        
        let day = RPlaceDay()
        day.number = 2
        day.lessons.append(lesson1)
        day.lessons.append(lesson2)
        day.lessons.append(lesson3)
        day.lessons.append(lesson4)
        return day
    }
    
    static func getPlaceDay5() -> RPlaceDay {
        
        let lesson1 = RPlaceLesson()
        lesson1.time = "11:30 - 13:00"
        
        let subgroup11 = RPlaceSubgroup()
        subgroup11.number = 0
        subgroup11.subject = "Физическая культура что-то там еще"
        subgroup11.type = 2
        subgroup11.groups.append(1)
        subgroup11.groups.append(2)
        subgroup11.professors.append(78)
        lesson1.subgroups.append(subgroup11)
        
        
        let lesson4 = RPlaceLesson()
        lesson4.time = "15:10 - 16:40"
        
        let subgroup41 = RPlaceSubgroup()
        subgroup41.number = 0
        subgroup41.subject = "Вычислительная математика"
        subgroup41.type = 2
        subgroup41.groups.append(4)
        subgroup41.professors.append(32)
        lesson4.subgroups.append(subgroup41)
        
        
        let day = RPlaceDay()
        day.number = 5
        day.lessons.append(lesson1)
        day.lessons.append(lesson4)
        return day
    }
    
    static func getPlaceDay0() -> RPlaceDay {
        
        let lesson1 = RPlaceLesson()
        lesson1.time = "33:33 - 33:00"
        
        let subgroup11 = RPlaceSubgroup()
        subgroup11.number = 0
        subgroup11.subject = "sdsdsdsd"
        subgroup11.type = 2
        subgroup11.groups.append(1)
        subgroup11.groups.append(2)
        subgroup11.professors.append(32)
        subgroup11.professors.append(44)
        lesson1.subgroups.append(subgroup11)
        
        
        let lesson3 = RPlaceLesson()
        lesson3.time = "15:10 - 16:40"
        
        let subgroup31 = RPlaceSubgroup()
        subgroup31.number = 0
        subgroup31.subject = "ffffff"
        subgroup31.type = 2
        subgroup31.groups.append(4)
        subgroup31.groups.append(9)
        subgroup31.professors.append(95)
        subgroup31.professors.append(3)
        lesson3.subgroups.append(subgroup31)
        
        
        let day = RPlaceDay()
        day.number = 0
        day.lessons.append(lesson1)
        day.lessons.append(lesson3)
        return day
    }
    
    static func getPlaceWeek1() -> RPlaceWeek {
        let week = RPlaceWeek()
        week.number = 0
        week.days.append(getPlaceDay0())

        return week
    }
    
    static func getPlaceWeek2() -> RPlaceWeek {
        let week = RPlaceWeek()
        week.number = 1
        week.days.append(getPlaceDay0())
        week.days.append(getPlaceDay2())
        week.days.append(getPlaceDay5())

        return week
    }
    
    static func getPlaceWeek3() -> RPlaceWeek {
        let week = RPlaceWeek()
        week.number = 1
        week.days.append(getPlaceDay5())

        return week
    }
    
    
    static func addPlaceTimetable99() {
        
        let timetable = RPlaceTimetable()
        timetable.placeId = 99

        timetable.weeks.append(getPlaceWeek1())
        timetable.weeks.append(getPlaceWeek2())
        
        DataManager.shared.write(placeTimetable: timetable)
    }
    
    static func addPlaceTimetable0() {
        let timetable = RPlaceTimetable()
        timetable.placeId = 0

        timetable.weeks.append(getPlaceWeek1())
        timetable.weeks.append(getPlaceWeek3())
        
        DataManager.shared.write(placeTimetable: timetable)
    }
}
