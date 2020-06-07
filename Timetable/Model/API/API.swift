//
//  API.swift
//  Timetable
//
//  Created by art-off on 07.06.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

struct API {
    
    static let address = "https://timetable.mysibsau.ru"
    
    // MARK: - Group
    static func groups() -> URL {
        return URL(string: "\(address)/groups")!
    }
    
    static func groupsHash() -> URL {
        return URL(string: "\(address)/groups/hash")!
    }
    
    static func timetable(forGroupId groupId: Int, week: Int) -> URL {
        return URL(string: "\(address)/timetable/group/\(groupId)/\(week)")!
    }
    
    // MARK: - Professor
    static func professors() -> URL {
        return URL(string: "\(address)/professors")!
    }
    
    static func professorsHash() -> URL {
        return URL(string: "\(address)/professors/hash")!
    }
    
    static func timetable(forProfessorId professorId: Int, week: Int) -> URL {
        return URL(string: "\(address)/timetable/professor/\(professorId)/\(week)")!
    }
    
    // MARK: - Place
    static func places() -> URL {
        return URL(string: "\(address)/places")!
    }
    
    static func placesHash() -> URL {
        return URL(string: "\(address)/places/hash")!
    }
    
    static func timetable(forPlaceId placeId: Int, week: Int) -> URL {
        return URL(string: "\(address)/timetable/place/\(placeId)/\(week)")!
    }
    
}
