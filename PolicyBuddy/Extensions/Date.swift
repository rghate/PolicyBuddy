//
//  Date.swift
//  PolicyBuddy
//
//  Created by Rupali on 21/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import Foundation

extension Date {
    
    enum IntervalType: String {
        case Days
        case Hours
        case Minutes
        case Seconds
        case NONE
        
        var description: String {
            self.rawValue.capitalized
        }
    }

    /**
     function to calculate offset between two dates.
     returns: CalenderComponent object with calculated offsets in form of days. hours, minuts and seconds.
     **/
    func offsetFrom(date: Date) -> CalenderComponent {
        let dayHourMinuteSecond: Set<Calendar.Component> = [.day, .hour, .minute, .second]
        let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: date, to: self)
        
        var calenderComp = CalenderComponent()

        calenderComp.seconds = difference.second ?? 0
        calenderComp.minutes = difference.minute ?? 0
        calenderComp.hours = difference.hour ?? 0
        calenderComp.days = difference.day ?? 0
        
        return calenderComp
    }
    
    /**
     function to calculate max offset between two dates.
     returns: touple with max interval type (either days, hours, minutes or sec) and type of max interval
     **/
    func maxOffsetFrom(date: Date) -> (Int, IntervalType) {

        let component = offsetFrom(date: date)
        
        return component.days > 0 ? (component.days, .Days) :
            component.hours > 0 ? (component.hours, .Hours) :
            component.minutes > 0 ? (component.minutes, .Minutes) :
            (component.seconds, .Seconds)
    }
    
}
