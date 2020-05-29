//
//  DateHelper.swift
//  Timetable
//
//  Created by art-off on 26.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

class DateHelper {
    
    // FIXME: Объединить с нижним методом
    static func getDatesEvenWeek() -> [(weekday: String, date: String)] {
        // номер текущей недели
        let currWeek = Calendar.current.component(.weekOfYear, from: Date.today)
        
        // проверяем, четная ли текущая неделя
        let currWeekIsEven = (currWeek % 2 == 1 && UserDefaultsConfig.firstWeekIsEven)
                              || (currWeek % 2 == 0 && !UserDefaultsConfig.firstWeekIsEven)
        
        let evenWeekMonday: Date
        if currWeekIsEven {
            /// если четная, то понедельник четной недели - предыдущий
            evenWeekMonday = Date.today.previous(.monday, considerToday: true)
        } else {
            /// если не четная, то понедельник четной недели - следующий
            evenWeekMonday = Date.today.next(.monday)
        }
        
        let calendar = Calendar.current
        
        var weekdaysAndDates = [(String, String)]()
        
        let shortWeekdaysInRussian = Date.shortWeekdaysInRussian
        
        // добавляем все дни недели и даты, соответствующие им
        for (i, weekday) in shortWeekdaysInRussian.enumerated() {
            let date = calendar.date(byAdding: DateComponents(day: i), to: evenWeekMonday)!
            let shortDate = DateFormatter.shortDateFormatter.string(from: date)
            let weekdayAndDate = (weekday, shortDate)
            weekdaysAndDates.append(weekdayAndDate)
        }
        
        return weekdaysAndDates
    }
    
    static func getDatesNotEvenWeek() -> [(weekday: String, date: String)] {
        // номер текущей недели
        let currWeek = Calendar.current.component(.weekOfYear, from: Date.today)
        
        // проверяем, четная ли текущая неделя
        let currWeekIsEven = (currWeek % 2 == 1 && UserDefaultsConfig.firstWeekIsEven)
                              || (currWeek % 2 == 0 && !UserDefaultsConfig.firstWeekIsEven)
        
        let evenWeekMonday: Date
        if !currWeekIsEven {
            /// если четная, то понедельник четной недели - предыдущий
            evenWeekMonday = Date.today.previous(.monday, considerToday: true)
        } else {
            /// если не четная, то понедельник четной недели - следующий
            evenWeekMonday = Date.today.next(.monday)
        }
        
        let calendar = Calendar.current
        
        var weekdaysAndDates = [(String, String)]()
        
        let shortWeekdaysInRussian = Date.shortWeekdaysInRussian
        
        // добавляем все дни недели и даты, соответствующие им
        for (i, weekday) in shortWeekdaysInRussian.enumerated() {
            let date = calendar.date(byAdding: DateComponents(day: i), to: evenWeekMonday)!
            let shortDate = DateFormatter.shortDateFormatter.string(from: date)
            let weekdayAndDate = (weekday, shortDate)
            weekdaysAndDates.append(weekdayAndDate)
        }
        
        return weekdaysAndDates
    }
    
}
