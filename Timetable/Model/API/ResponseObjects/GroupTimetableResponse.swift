//
//  GroupTimetableResponse.swift
//  Timetable
//
//  Created by art-off on 31.08.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

class GroupTimetableResponse: Decodable {
    
    let groupName: String
    var evenWeek: [GroupDayResponse]
    var oddWeek: [GroupDayResponse]
    let groupHash: String
    
    enum CodingKeys: String, CodingKey {
        case groupName = "group"
        case evenWeek = "even_week"
        case oddWeek = "odd_week"
        case groupHash = "hash"
    }
    
}

class GroupDayResponse: Decodable {
    
    let number: Int
    var lessons: [GroupLessonResponse]

    enum CodingKeys: String, CodingKey {
        case number = "day"
        case lessons
    }
    
}

class GroupLessonResponse: Decodable {
    
    let time: String
    var subgroups: [GroupSubgroupResponse]
    
    enum CodingKeys: String, CodingKey {
        case time
        case subgroups
    }
    
}

class GroupSubgroupResponse: Decodable {
    
    let number: Int
    let subject: String
    let type: Int
    let place: String
    let professor: String
    
    enum CodingKeys: String, CodingKey {
        case number = "num"
        case subject = "name"
        case type
        case place
        case professor = "teacher"
    }
    
}
