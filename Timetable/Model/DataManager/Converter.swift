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
        0: "(Лекция)",
        1: "(Практика)",
        2: "(Лабораторная работа)",
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
                            subject: subgroup.subject,
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
    
//    // MARK: Перевод объекта РАСПИСАНИЯ ПРОФЕССОРА Realm к структуре, используемой в приложении
//    func convertProfessorTimetable(from timetable: RProfessorTimetable, professorName: String) -> ProfessorTimetable {
//        var professorWeeks = [ProfessorWeek]()
//
//        // пробегаемся по всем неделям (по дву)
//        for week in timetable.weeks {
//
//            // заполняем массив дней nil, потом если будут учебные дни в этой недели - заменю значение
//            var professorDays: [ProfessorDay?] = [nil, nil, nil, nil, nil, nil]
//
//            // пробегаемся во всем дням недели
//            for day in week.days {
//
//                var professorLessons = [ProfessorLesson]()
//                
//                // пробегаемся по всем занятиям дня
//                for lesson in day.lessons {
//
//                    var professorSubgroups = [ProfessorSubgroup]()
//                    
//                    // пробегаемся по всех подргуппам занятия
//                    for subgroup in lesson.subgroups {
//
//                        var groupsName = [String]()
//                        // берем имя групп из БД с помощью id
//                        for id in subgroup.groups {
//                            let group = DataManager.shared.getProfessor(withId: id)
//                            if let group = group {
//                                groupsName.append(group.name)
//                            } else {
//                                groupsName.append("Ошибка")
//                            }
//                        }
//                        
//                        // берем имя кабинета с помощью id
//                        let optionalPlace = DataManager.shared.getPlace(withId: subgroup.place)
//                        let placeName: String
//                        if let place = optionalPlace {
//                            placeName = place.name
//                        } else {
//                            placeName = "Неопознанное"
//                        }
//                        
//                        // копируем подргуппу
//                        let professorSubgroup = ProfessorSubgroup(
//                            number: subgroup.number,
//                            subject: subgroup.subject,
//                            type: subgroupType[subgroup.type] ?? "(Неопознанный)",
//                            groups: groupsName,
//                            groupsId: Array(subgroup.groups),
//                            place: placeName,
//                            placeId: subgroup.place)
//
//                        professorSubgroups.append(professorSubgroup)
//                    }
//                    
//                    // добавляем занятие в массив занятий
//                    let professorLesson = ProfessorLesson(time: lesson.time, subgroups: professorSubgroups)
//                    professorLessons.append(professorLesson)
//                }
//                
//                let professorDay = ProfessorDay(lessons: professorLessons)
//                // проверяем, подходит ли number для вставки в массив groupDays (0-понедельник, 5-суббота)
//                if day.number >= 0 && day.number <= 5 {
//                    // заменяем nil
//                    professorDays[day.number] = professorDay
//                }
//            }
//
//            let professorWeek = ProfessorWeek(days: professorDays)
//            professorWeeks.append(professorWeek)
//        }
//
//        let professorTimetable = ProfessorTimetable(professorId: timetable.professorId, professorName: professorName, weeks: professorWeeks)
//        return professorTimetable
//    }
//    
//    // MARK: Перевод объекта РАСПИСАНИЯ КАБИНЕТА Realm к структуре, используемой в приложении
//    func convertPlaceTimetable(from timetable: RPlaceTimetable, placeName: String) -> PlaceTimetable {
//        var placeWeeks = [PlaceWeek]()
//
//        // пробегаемся по всем неделям (по дву)
//        for week in timetable.weeks {
//
//            // заполняем массив дней nil, потом если будут учебные дни в этой недели - заменю значение
//            var placeDays: [PlaceDay?] = [nil, nil, nil, nil, nil, nil]
//
//            // пробегаемся во всем дням недели
//            for day in week.days {
//
//                var placeLessons = [PlaceLesson]()
//                
//                // пробегаемся по всем занятиям дня
//                for lesson in day.lessons {
//
//                    var placeSubgroups = [PlaceSubgroup]()
//                    
//                    // пробегаемся по всех подргуппам занятия
//                    for subgroup in lesson.subgroups {
//
//                        var groupsName = [String]()
//                        // берем имя группы из БД с помощью id
//                        for id in subgroup.groups {
//                            let group = DataManager.shared.getPlace(withId: id)
//                            if let group = group {
//                                groupsName.append(group.name)
//                            } else {
//                                groupsName.append("Ошибка")
//                            }
//                        }
//                        
//                        var professorsName = [String]()
//                        // берем имя преподаватели из БД с помощью id
//                        for id in subgroup.professors {
//                            let professor = DataManager.shared.getProfessor(withId: id)
//                            if let professor = professor {
//                                professorsName.append(professor.name)
//                            } else {
//                                professorsName.append("Ошибка")
//                            }
//                        }
//                        
//                        let placeSubgroup = PlaceSubgroup(
//                            number: subgroup.number,
//                            subject: subgroup.subject,
//                            type: subgroupType[subgroup.type] ?? "(Неопознанный)",
//                            groups: groupsName,
//                            groupsId: Array(subgroup.groups),
//                            professors: professorsName,
//                            professorsId: Array(subgroup.professors))
//
//                        placeSubgroups.append(placeSubgroup)
//                    }
//                    
//                    // добавляем занятие в массив занятий
//                    let placeLesson = PlaceLesson(time: lesson.time, subgroups: placeSubgroups)
//                    placeLessons.append(placeLesson)
//                }
//                
//                let placeDay = PlaceDay(lessons: placeLessons)
//                // проверяем, подходит ли number для вставки в массив groupDays (0-понедельник, 5-суббота)
//                if day.number >= 0 && day.number <= 5 {
//                    // заменяем nil
//                    placeDays[day.number] = placeDay
//                }
//            }
//
//            let placeWeek = PlaceWeek(days: placeDays)
//            placeWeeks.append(placeWeek)
//        }
//
//        let placeTimetable = PlaceTimetable(placeId: timetable.placeId, placeName: placeName, weeks: placeWeeks)
//        return placeTimetable
//    }
    
}
