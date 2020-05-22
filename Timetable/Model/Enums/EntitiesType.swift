//
//  EntitiesType.swift
//  Timetable
//
//  Created by art-off on 04.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

enum EntitiesType: String {
    case group
    case professor
    case place
    
    var raw: String {
        switch self {
        case .group: return "group"
        case .professor: return "professor"
        case .place: return "place"
        }
    }
}
