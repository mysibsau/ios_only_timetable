//
//  ApiManager.swift
//  Timetable
//
//  Created by art-off on 07.06.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation
import RealmSwift

class ApiManager {
    
    // MARK: Curr Week Number
    static func loadCurrWeekIsEwenTask(complition: @escaping (Bool?) -> Void) -> URLSessionDataTask {
        let url = API.currWeekIsEven()
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                (200..<300).contains(httpResponse.statusCode) else {
                    complition(nil)
                    return
            }
            
            guard let data = data else {
                complition(nil)
                return
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], let currWeekIsEven = json["isEven"] as? String else {
                    complition(nil)
                    return
                }
                
                if currWeekIsEven.lowercased() == "true" {
                    complition(true)
                } else if currWeekIsEven.lowercased() == "false" {
                    complition(false)
                } else {
                    complition(nil)
                }
            } catch let jsonError {
                print(jsonError)
                complition(nil)
            }
        }
        
        return task
    }
    
    // MARK: - Entities
    // MARK: Groups
    static func loadGroupsTask(complition: @escaping ([RGroup]?) -> Void) -> URLSessionDataTask {
        let url = API.groups()
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                (200..<300).contains(httpResponse.statusCode) else {
                    complition(nil)
                    return
            }
            
            guard let data = data else {
                complition(nil)
                return
            }
            
            do {
                let groups = try JSONDecoder().decode([RGroup].self, from: data)
                complition(groups)
            } catch let jsonError {
                print(jsonError)
                complition(nil)
            }
        }
        
        return task
    }
    
    
    // MARK: Professors
    static func loadProfessorsTask(complition: @escaping ([RProfessor]?) -> Void) -> URLSessionDataTask {
        let url = API.professors()

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                (200..<300).contains(httpResponse.statusCode) else {
                    complition(nil)
                    return
            }
            
            guard let data = data else {
                complition(nil)
                return
            }
            
            do {
                let professors = try JSONDecoder().decode([RProfessor].self, from: data)
                complition(professors)
            } catch let jsonError {
                print(jsonError)
                complition(nil)
            }
        }
        
        return task
    }
    
    
    // MARK: Places
    static func loadPlacesDataTask(complition: @escaping ([RPlace]?) -> Void) -> URLSessionDataTask {
        let url = API.places()
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                (200..<300).contains(httpResponse.statusCode) else {
                    complition(nil)
                    return
            }
            
            guard let data = data else {
                complition(nil)
                return
            }
            
            do {
                let places = try JSONDecoder().decode([RPlace].self, from: data)
                complition(places)
            } catch let jsonError {
                print(jsonError)
                complition(nil)
            }
        }
        
        return task
    }
    
    
    // MARK: - Timetalbe
    // MARK: Group
    static func loadDaysOfWeekTask(forGroupId groupId: Int, weekNumber: Int, complition: @escaping ([RGroupDay]?) -> Void) -> URLSessionDataTask {
        let url = API.timetable(forGroupId: groupId, week: weekNumber)
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                (200..<300).contains(httpResponse.statusCode) else {
                    complition(nil)
                    return
            }
            
            guard let data = data else {
                complition(nil)
                return
            }
            
            do {
                let groupDays = try JSONDecoder().decode([RGroupDay].self, from: data)
                complition(groupDays)
            } catch let jsonError {
                print(jsonError)
                complition(nil)
            }
        }
        
        return task
    }
    
    static func loadTimetableTask(forGroupId groupId: Int, complition: @escaping (RGroupTimetable?) -> Void) -> DataTasks {
        
        let timetable = RGroupTimetable()
        timetable.groupId = groupId
        
        var countDownloadedWeeks = 0
        let taskDone = {
            countDownloadedWeeks += 1
            
            // Если выполнены обе задачи - выходим
            if countDownloadedWeeks == 2 {
                complition(timetable)
            }
        }
        
        let task1 = loadDaysOfWeekTask(forGroupId: groupId, weekNumber: 1) { days1 in
            let week1 = RGroupWeek()
            week1.number = 0
            
            guard let days1 = days1 else {
                complition(nil)
                return
            }
            
            for day in days1 {
                week1.days.append(day)
            }
            
            // если загрузится первая - просто встанет на первое место
            // если вторая - то тоже встанет на перове
            timetable.weeks.insert(week1, at: 0)
            
            taskDone()
        }
        
        let task2 = loadDaysOfWeekTask(forGroupId: groupId, weekNumber: 2) { days2 in
            let week2 = RGroupWeek()
            week2.number = 1
            
            guard let days2 = days2 else {
                complition(nil)
                return
            }
            
            for day in days2 {
                week2.days.append(day)
            }
            
            // если загрузится первая - встанет на первое место, затем первая неделя insert at 0
            // если вторая - просто встанет на второе место
            timetable.weeks.append(week2)
            
            taskDone()
        }
        
        let dataTasks = DataTasks()
        dataTasks.add(task: task1)
        dataTasks.add(task: task2)
        
        return dataTasks
    }
    
    
    // MARK: Professor
    static func loadDaysOfWeekTask(forProfessorId professorId: Int, weekNumber: Int, complition: @escaping ([RProfessorDay]?) -> Void) -> URLSessionDataTask {
        let url = API.timetable(forProfessorId: professorId, week: weekNumber)
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                (200..<300).contains(httpResponse.statusCode) else {
                    complition(nil)
                    return
            }
            
            guard let data = data else {
                complition(nil)
                return
            }
            
            do {
                let professorDays = try JSONDecoder().decode([RProfessorDay].self, from: data)
                complition(professorDays)
            } catch let jsonError {
                print(jsonError)
                complition(nil)
            }
        }
        
        return task
    }
    
    
    static func loadTimetableTask(forProfessorId professorId: Int, complition: @escaping (RProfessorTimetable?) -> Void) -> DataTasks {
        
        let timetable = RProfessorTimetable()
        timetable.professorId = professorId
        
        var countDownloadedWeeks = 0
        let taskDone = {
            countDownloadedWeeks += 1
            
            // Если выполнены обе задачи - выходим
            if countDownloadedWeeks == 2 {
                complition(timetable)
            }
        }
        
        let task1 = loadDaysOfWeekTask(forProfessorId: professorId, weekNumber: 1) { days1 in
            let week1 = RProfessorWeek()
            week1.number = 0
            
            guard let days1 = days1 else {
                complition(nil)
                return
            }
            
            for day in days1 {
                week1.days.append(day)
            }
            
            // если загрузится первая - просто встанет на первое место
            // если вторая - то тоже встанет на перове
            timetable.weeks.insert(week1, at: 0)
            
            taskDone()
        }
        
        let task2 = loadDaysOfWeekTask(forProfessorId: professorId, weekNumber: 2) { days2 in
            let week2 = RProfessorWeek()
            week2.number = 1
            
            guard let days2 = days2 else {
                complition(nil)
                return
            }
            
            for day in days2 {
                week2.days.append(day)
            }
            
            // если загрузится первая - встанет на первое место, затем первая неделя insert at 0
            // если вторая - просто встанет на второе место
            timetable.weeks.append(week2)
            
            taskDone()
        }
        
        let dataTasks = DataTasks()
        dataTasks.add(task: task1)
        dataTasks.add(task: task2)
        
        return dataTasks
    }
    
    
    // MARK: Place
    static func loadDaysOfWeekTask(forPlaceId placeId: Int, weekNumber: Int, complition: @escaping ([RPlaceDay]?) -> Void) -> URLSessionDataTask {
        let url = API.timetable(forPlaceId: placeId, week: weekNumber)
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                (200..<300).contains(httpResponse.statusCode) else {
                    complition(nil)
                    return
            }
            
            guard let data = data else {
                complition(nil)
                return
            }
            
            do {
                let placeDays = try JSONDecoder().decode([RPlaceDay].self, from: data)
                complition(placeDays)
            } catch let jsonError {
                print(jsonError)
                complition(nil)
            }
        }
        
        return task
    }
    
    
    static func loadTimetableTask(forPlaceId placeId: Int, complition: @escaping (RPlaceTimetable?) -> Void) -> DataTasks {
        
        let timetable = RPlaceTimetable()
        timetable.placeId = placeId
        
        var countDownloadedWeeks = 0
        let taskDone = {
            countDownloadedWeeks += 1
            
            // Если выполнены обе задачи - выходим
            if countDownloadedWeeks == 2 {
                complition(timetable)
            }
        }
        
        let task1 = loadDaysOfWeekTask(forPlaceId: placeId, weekNumber: 1) { days1 in
            let week1 = RPlaceWeek()
            week1.number = 0
            
            guard let days1 = days1 else {
                complition(nil)
                return
            }
            
            for day in days1 {
                week1.days.append(day)
            }
            
            // если загрузится первая - просто встанет на первое место
            // если вторая - то тоже встанет на перове
            timetable.weeks.insert(week1, at: 0)
            
            taskDone()
        }
        
        let task2 = loadDaysOfWeekTask(forPlaceId: placeId, weekNumber: 2) { days2 in
            let week2 = RPlaceWeek()
            week2.number = 1
            
            guard let days2 = days2 else {
                complition(nil)
                return
            }
            
            for day in days2 {
                week2.days.append(day)
            }
            
            // если загрузится первая - встанет на первое место, затем первая неделя insert at 0
            // если вторая - просто встанет на второе место
            timetable.weeks.append(week2)
            
            taskDone()
        }
        
        let dataTasks = DataTasks()
        dataTasks.add(task: task1)
        dataTasks.add(task: task2)
        
        return dataTasks
    }

}
