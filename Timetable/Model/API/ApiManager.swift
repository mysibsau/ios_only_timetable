//
//  ApiManager.swift
//  Timetable
//
//  Created by art-off on 07.06.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

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
    
    // MARK: - Обработка скачанных групп
    static func handleGroupsResponse(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> [RGroup]? {
        guard error == nil else { return nil }
        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else { return nil }
        guard let data = data else { return nil }
        
        do {
            let groupsResponse = try JSONDecoder().decode([GroupResponse].self, from: data)
            let groups = ResponseConverter.converteGroupResponseToRGroup(groupsResponse: groupsResponse)
            return groups
        } catch let jsonError {
            print(jsonError)
            return nil
        }
    }
    
    // MARK: - Обработка скачанного хеша
    static func handleHashResponse(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> String? {
        guard error == nil else { return nil }
        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else { return nil }
        guard let data = data else { return nil }
        
        do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                let hash = json["hash"] as? String else {
                    return nil
            }
            return hash
        } catch let jsonError {
            print(jsonError)
            return nil
        }
    }
    
    // MARK: - Обработка скачанного расписания групп
    static func handleGroupTimetableResponse(groupId: Int, _ data: Data?, _ response: URLResponse?, _ error: Error?) -> (timetable: RGroupTimetable?, groupHash: String?) {
        guard error == nil else { return (nil, nil) }
        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else { return (nil, nil) }
        guard let data = data else { return (nil, nil) }
        
        do {
            let groupTimetableResponse = try JSONDecoder().decode([GroupTimetableResponse].self, from: data)
            
            // Антон отправляет массивом с одним элементом (:
            guard let groupTimetableResponseFirst = groupTimetableResponse.first else { return (nil, nil) }
            
            let groupTimetable = ResponseConverter.converteGroupTimetableResponseToRGroupTimetable(
                groupTimetableResponse: groupTimetableResponseFirst,
                groupId: groupId)
            
            return (groupTimetable, groupTimetableResponseFirst.groupHash)
        } catch let jsonError {
            print(jsonError)
            return (nil, nil)
        }
    }

}
