//
//  DateHelper.swift
//  Timetable
//
//  Created by art-off on 26.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

class DateHelper {
    
    static func currWeekIsEven() -> Bool {
        // номер текущей недели
        let currWeek = Calendar.current.component(.weekOfYear, from: Date.today)
        let firstWeekIsEven = UserDefaultsConfig.firstWeekIsEven
        
        // проверяем, четная ли текущая неделя
        let currWeekIsEven = (currWeek % 2 == 1 && firstWeekIsEven)
                              || (currWeek % 2 == 0 && !firstWeekIsEven)
        
        return currWeekIsEven
    }
    
    
    static func setFirstWeekIsEven(fromCurrWeekIsEven currWeekIsEven: Bool) {
        let currWeek = Calendar.current.component(.weekOfYear, from: Date.today)
        
        let firstWeekIsEven = (currWeek % 2 == 1 && currWeekIsEven)
                               || (currWeek % 2 == 0 && !currWeekIsEven)
        
        UserDefaultsConfig.firstWeekIsEven = firstWeekIsEven
    }
    
    
    // FIXME: возвращает на один номер больше
    static func getCurrNumberWeekday() -> Int {
        let calendar = Calendar.current
        
        // - 1 потому что он возвращает номер начиная с воскресенья
        var numberCurrWeek = calendar.component(.weekday, from: Date.today) - 1
        
        if numberCurrWeek < 1 {
            numberCurrWeek += 7
        }
        
        return numberCurrWeek
    }
    
    // FIXME: Объединить с нижним методом
    static func getDatesEvenWeek() -> [(weekday: String, date: String)] {
        let evenWeekMonday: Date
        if currWeekIsEven() {
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
        let evenWeekMonday: Date
        if !currWeekIsEven() {
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
