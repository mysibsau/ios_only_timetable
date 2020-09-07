//
//  GroupsResponse.swift
//  Timetable
//
//  Created by art-off on 07.09.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

class GroupResponse: Decodable {
    
    let id: Int
    let name: String
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email = "mail"
    }
    
}
