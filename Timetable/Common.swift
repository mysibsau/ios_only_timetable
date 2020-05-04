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
    
    static func getWeek1() -> Week {
        let week = Week(days: [
            getDay1(), nil, nil, getDay2(), getDay1(), nil, getDay1()
        ])
        return week
    }
    
    static func getWeek2() -> Week {
        let week = Week(days: [
            nil, nil, nil, getDay1(), getDay1(), nil, getDay2()
        ])
        return week
    }
}
