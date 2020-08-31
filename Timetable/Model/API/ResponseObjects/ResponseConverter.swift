//
//  ResponseConverter.swift
//  Timetable
//
//  Created by art-off on 31.08.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

class ResponseConverter {
    
    static func converteGroupTimetableResponseToRGroupTimetable(groupTimetableResponse: GroupTimetableResponse, groupId: Int) -> RGroupTimetable {
        
        let groupTimetable = RGroupTimetable()
        groupTimetable.groupId = groupId
        
        let groupEvenWeek = converteGroupDaysResponseToRGroupWeek(groupDaysResponse: groupTimetableResponse.evenWeek)
        let groupOddWeek = converteGroupDaysResponseToRGroupWeek(groupDaysResponse: groupTimetableResponse.oddWeek)
        groupTimetable.weeks.append(groupEvenWeek)
        groupTimetable.weeks.append(groupOddWeek)
        
        return groupTimetable
    }
    
    private static func converteGroupDaysResponseToRGroupWeek(groupDaysResponse: [GroupDayResponse]) -> RGroupWeek {
        let groupWeek = RGroupWeek()
        
        for groupDayResponse in groupDaysResponse {
            let groupDay = RGroupDay()
            
            groupDay.number = groupDayResponse.number
            
            for groupLessonResponse in groupDayResponse.lessons {
                let groupLesson = RGroupLesson()
                
                groupLesson.time = groupLessonResponse.time
                
                for groupSubgroupResponse in groupLessonResponse.subgroups {
                    let groupSubgroup = RGroupSubgroup()
                    groupSubgroup.number = groupSubgroupResponse.number
                    groupSubgroup.subject = groupSubgroupResponse.subject
                    groupSubgroup.professor = groupSubgroupResponse.professor
                    groupSubgroup.place = groupSubgroupResponse.place
                    groupSubgroup.type = groupSubgroupResponse.type
                    
                    groupLesson.subgroups.append(groupSubgroup)
                }
                
                groupDay.lessons.append(groupLesson)
            }
            
            // Если в этот день есть пары - добавляем
            if !groupDay.lessons.isEmpty {
                groupWeek.days.append(groupDay)
            }
        }
        
        return groupWeek
    }
    
}
