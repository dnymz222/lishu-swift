//
//  CalendarProgessModel.swift
//  widgetExtension
//
//  Created by xueping wang on 2025/1/25.
//

import SwiftUI

class CalendarProgessModel{
    let date: Date
    var calendar:Calendar
    
    var dayofYear: Int
    var daysofYear: Int
    let year: Int
    
    let percent: String
    
    let progess: String
    let name: String
    
    let endAngle: Angle
    

    
    init(date: Date,_ idendifier: Calendar.Identifier) {
        
        self.date = date
        self.calendar = Calendar(identifier: idendifier)
        self.calendar.timeZone = TimeZone.current
        
        
        var compoenets =  calendar.dateComponents([.year], from: date)
      
        self.year = compoenets.year ?? 1
        
        let nowStartYear = CalendarProgessModel.startYearDate(self.year, 1,idendifier)
        let nextStartYear = CalendarProgessModel.startYearDate(self.year + 1, 10,idendifier)
        
    
        
        self.daysofYear  =  Int( floor( nextStartYear.timeIntervalSince(nowStartYear) / 86400.0))
        
  
        self.dayofYear =  Int( floor(date.timeIntervalSince(nowStartYear) / 86400.0)) + 1

        
        

        
        
        
        self.progess = String(format: "%d/%d", self.dayofYear,self.daysofYear)
        
        
        if idendifier == .gregorian {
            self.name = NSLocalizedString("calendar_group_gregorian", comment: "")
            
        } else if idendifier == .chinese{
            
            self.name = NSLocalizedString("calendar_group_chinese", comment: "")
        } else if idendifier == .hebrew {
            self.name = NSLocalizedString("calendar_group_hebrew", comment: "")
        } else {
            
            self.name = NSLocalizedString("calendar_group_islamic", comment: "")
        }
        

        
        let daypercent = Double(self.dayofYear) / Double(self.daysofYear)
        
        self.percent  = String(format: "%d%@", lround(daypercent * 100),"%")
        
        self.endAngle = Angle(radians: daypercent * Double.pi * 2 - Double.pi / 2)
        
        
        
        
    }
    
    
    static  func startYearDate(_ year: Int,_ second: Int, _ idendifier: Calendar.Identifier) -> Date {
        
        var calendar = Calendar(identifier: idendifier)
        calendar.timeZone = TimeZone.current
        var compents = DateComponents()
        compents.year = year
        compents.month = 1
        compents.day = 1
        compents.hour = 0
        compents.minute = 0
        compents.second = second
        
        return calendar.date(from: compents) ?? Date()
        
    }
    
    
}
