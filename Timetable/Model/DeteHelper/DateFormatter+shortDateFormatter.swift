//
//  DateFormatter+shortDateFormatter.swift
//  Timetable
//
//  Created by art-off on 29.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static let shortDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        return dateFormatter
    }()
    
}
