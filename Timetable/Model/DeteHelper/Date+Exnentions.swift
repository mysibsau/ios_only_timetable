//
//  Date+Exnentions.swift
//  Timetable
//
//  Created by art-off on 29.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

extension Date {
    
    enum Weekday: String {
        case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    }
    
    static var today: Date {
        return Date()
    }
    
    func next(_ weekday: Weekday, considerToday: Bool = false) -> Date {
        return get(.forward, weekday, considerToday: considerToday)
    }
    
    func previous(_ weekday: Weekday, considerToday: Bool = false) -> Date {
        return get(.backward, weekday, considerToday: considerToday)
    }
    
    private func get(_ direction: Calendar.SearchDirection, _ weekday: Weekday, considerToday consider: Bool = false) -> Date {
        // String значения дней недели
        let weekdayName = weekday.rawValue
        let weekdaysName = getWeekdaysInEnglish().map { $0.lowercased() }
        
        // Номер искомого дня
        let searchWeekdayIndex = weekdaysName.firstIndex(of: weekdayName)! + 1
        
        // FIXME: Возможно стоит заменить на грирорианский
        let calendar = Calendar.current
        
        // Если в поиск был ключен текущий день
        if consider && (calendar.component(.weekday, from: self) == searchWeekdayIndex) {
            return self
        }
        
        let nextDateComponent = DateComponents(weekday: searchWeekdayIndex)
        
        let date = calendar.nextDate(
            after: self,
            matching: nextDateComponent,
            matchingPolicy: .nextTime,
            direction: direction)
        
        return date!
    }
    
    
    private func getWeekdaysInEnglish() -> [String] {
        var calendar = Calendar.current
        calendar.locale = Locale.current
        return calendar.weekdaySymbols
    }
    
}

extension Date {
    
    static let shortWeekdaysInRussian = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб"]
    
}
