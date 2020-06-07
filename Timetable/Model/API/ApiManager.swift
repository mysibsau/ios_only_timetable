//
//  ApiManager.swift
//  Timetable
//
//  Created by art-off on 07.06.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

class ApiManager {
    
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

}
