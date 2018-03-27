//
//  DateHelper.swift
//  Mon Pk & Moi
//
//  Created by Kevin Hassan on 24/03/2018.
//  Copyright © 2018 Kevin Hassan. All rights reserved.
//

import Foundation

class DateHelper{
    static var days = NSDateComponents() // Day and month
    static var cal = NSCalendar.current // Calendar used
    
    static func getDates(dateD: NSDate, dateF: NSDate) -> [NSDate]{
        
        var dates: [NSDate] = []
        var dayCount = 0
        while true {
            days.day = dayCount
            let date:NSDate = cal.date(byAdding : days as DateComponents, to: dateD as Date)! as NSDate
            if date.compare(dateF as Date) == .orderedDescending {
                break
            }
            dayCount += 1
            dates.append(date)
        }
        return dates
    }
}
