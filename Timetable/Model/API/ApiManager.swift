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
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let currWeekIsEven = json["isEven"] as? String else {
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
    
    // MARK: - Скачивание всех групп
    static func loadGroupsTask(complition: @escaping ([RGroup]?) -> Void) -> URLSessionDataTask {
        let url = API.groups()
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                complition(nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                complition(nil)
                return
            }
            
            guard let data = data else {
                complition(nil)
                return
            }
            
            do {
                let groupsResponse = try JSONDecoder().decode([RGroup].self, from: data)
                complition(groupsResponse)
            } catch let jsonError {
                print(jsonError)
                complition(nil)
            }
        }
        
        return task
    }
    
    // MARK: Скачивание расписания группы
    static func loadGroupTimetableTask(forGroupId groupId: Int, complition: @escaping (RGroupTimetable?, _ groupHash: String?) -> Void) -> URLSessionDataTask {
        let url = API.timetable(forGroupId: groupId)
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                complition(nil, nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                complition(nil, nil)
                return
            }
            
            guard let data = data else {
                complition(nil, nil)
                return
            }
            
            do {
                let groupTimetableResponse = try JSONDecoder().decode([GroupTimetableResponse].self, from: data)
                
                // Антон отправляет массивом с одним элементом (:
                guard let groupTimetableResponseFirst = groupTimetableResponse.first else {
                    complition(nil, nil)
                    return
                }
                
                let groupTimetable = ResponseConverter.converteGroupTimetableResponseToRGroupTimetable(
                    groupTimetableResponse: groupTimetableResponseFirst,
                    groupId: groupId)
                
                complition(groupTimetable, groupTimetableResponseFirst.groupHash)
            } catch let jsonError {
                print(jsonError)
                complition(nil, nil)
            }
        }
        
        return task
    }
    
    static func loadHashTask(for entitie: EntitiesType, complition: @escaping (String?) -> Void) -> URLSessionDataTask {
        let url: URL = API.groupsHash()
//        if entitie == .group {
//            url = API.groupsHash()
//        } else if entitie == .professor {
//            url = API.professorsHash()
//        } else {
//            url = API.placesHash()
//        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                complition(nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                complition(nil)
                return
            }
            
            guard let data = data else {
                complition(nil)
                return
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let hash = json["hash"] as? String else {
                        complition(nil)
                        return
                }
                complition(hash)
            } catch let jsonError {
                print(jsonError)
                complition(nil)
            }
        }
        
        return task
    }

}
