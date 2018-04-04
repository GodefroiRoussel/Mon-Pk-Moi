//
//  DateHelper.swift
//  monPkEtMoi
//
//  Created by Kevin HASSAN on 24/03/2018.
//  Copyright © 2018 CHU-polytech. All rights reserved.
//
import Foundation
import UIKit

class DateHelper{
    static var cal = NSCalendar.current
    static var days = NSDateComponents()
    
    static func getDates(dateD: NSDate, dateF: NSDate) -> [NSDate]{
        
        var dates: [NSDate] = []
        var dayCount = 0
        while true {
            days.day = dayCount
            days.hour = 0
            let date:NSDate = cal.date(byAdding : days as DateComponents, to: dateD as Date)! as NSDate
            if date.compare(dateF as Date) == .orderedDescending {
                break
            }
            dayCount += 1
            dates.append(date)
        }
        return dates
    }
    static func getDays(dateD: NSDate, dateF: NSDate) -> [[NSDate]?]{
        var week:[[NSDate]] = [[],[],[],[],[],[],[]]
        let dates:[NSDate] = DateHelper.getDates(dateD: dateD, dateF: dateF)
        var numJour: Int? = nil
        for date in dates{
            // Numéroté de 1 à 7
            numJour = cal.component(.weekday, from: date as Date)
            week[Jour().getJourIndex(jour:numJour!)].append(date)
        }
        return week
    }
    /// Changer une date en lui affectant une nouvelle heure et de nouvelle minute
    static func changeHour(date: NSDate, heureMin: NSDate) -> NSDate{
        var component1 = cal.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date as Date)
        var component2 = cal.dateComponents([.hour, .minute, .second], from: heureMin as Date)
        component1.hour = component2.hour
        component1.minute = component2.minute
        component1.second = component2.second
        let date = cal.date(from: component1)!
        return date as NSDate
    }
    
    static func startOfDay(day: NSDate) -> NSDate {
        let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let unitFlags: NSCalendar.Unit = [.minute, .hour, .day, .month, .year]
        var todayComponents = gregorian!.components(unitFlags, from: day as Date)
        todayComponents.hour = 0
        todayComponents.minute = 0
        return (gregorian?.date(from: todayComponents))! as NSDate
    }
    
    static func endOfDay(day: NSDate) -> NSDate {
        let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let unitFlags: NSCalendar.Unit = [.minute, .hour, .day, .month, .year]
        var todayComponents = gregorian!.components(unitFlags, from: day as Date)
        todayComponents.hour = 23
        todayComponents.minute = 59
        return (gregorian?.date(from: todayComponents))! as NSDate
    }
    
    
    //Check if a date is in interval of a certain number of days
    static func checkInterval(dateRDV: NSDate, interval numberDays: Int) -> Bool{
            days.day = -numberDays
            let dateDebutTraitement:NSDate = cal.date(byAdding : days as DateComponents, to: dateRDV as Date)! as NSDate
        return NSDate().isBetweeen(date: self.startOfDay(day: dateDebutTraitement), andDate: self.endOfDay(day: dateRDV))
    }
    
    
    static func substractDateInSeconds(heure1: NSDate, heure2: NSDate) -> Double{
        let date = changeHour(date: heure1, heureMin: heure2)
        return date.timeIntervalSince(NSDate() as Date)
    }
    
    
    static func getHours(hourD: NSDate, hourF: NSDate) -> [NSDate]{
        
        var hours: [NSDate] = []
        var hoursCount = 0
        days.day = 0
        while true {
            days.hour = hoursCount
            let hour:NSDate = cal.date(byAdding : days as DateComponents, to: hourD as Date)! as NSDate
            if hour.compare(hourF as Date) == .orderedDescending {
                break
            }
            hoursCount += 1
            hours.append(hour)
        }
        return hours
    }
    
    static func addHours(hourD: NSDate, nbHoursToAdd nbHours: Int) -> NSDate {
        days.day = 0
        days.hour = nbHours
        return cal.date(byAdding : days as DateComponents, to: hourD as Date)! as NSDate
    }
    
    static func addDays(dayD: NSDate, nbDaysToAdd nbDays: Int) -> NSDate {
        days.day = nbDays
        days.hour = 0
        return cal.date(byAdding : days as DateComponents, to: dayD as Date)! as NSDate
    }
}

/// Correspondance entre jours et chiffre
///
/// Dimanche correspond au jour 1 d'après le calendrier grégorien
struct Jour{
    var jours: [(String,Int)] = [("Lundi",2),("Mardi",3),("Mercredi",4),("Jeudi",5),("Vendredi",6),("Samedi",7),("Dimanche",1)]
    
    func getJourIndex(jour: Int) -> Int{
        var i = 0
        while (jours[i].1 != jour && i<jours.count) {
            i = i+1
        }
        return i
    }
}
