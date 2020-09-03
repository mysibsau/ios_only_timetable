//
//  Converter.swift
//  Timetable
//
//  Created by art-off on 27.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

// FIXME: Цикличные связи
// Этот класс использует методы DataManager (для взятия сущностей по id)
// Но и DataManager использует методы этого класса (конвертирует)
// Некоторая циаличная связь вышла, не очень хорошо

class Converter {
    
    static let shared = Converter()
    
    private let subgroupType = [
        1: "(Лекция)",
        2: "(Лабораторная работа)",
        3: "(Практика)",
    ]
    
    // MARK: Перевод объекта РАСПИСАНИЯ ГРУППЫ Realm к структуре, используемой в приложении
    func convertGroupTimetable(from timetable: RGroupTimetable, groupName: String) -> GroupTimetable {
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
                        let groupSubgroup = GroupSubgroup(
                            number: subgroup.number,
                            subject: subgroup.subject.capitalizinFirstLetter(),
                            type: subgroupType[subgroup.type] ?? "(Неопознанный)",
                            professor: subgroup.professor,
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

        let groupTimetable = GroupTimetable(groupId: timetable.groupId, groupName: groupName, weeks: groupWeeks)
        return groupTimetable
    }
    
}
