//
//  YearModel.swift
//  widgetExtension
//
//  Created by xueping wang on 2025/1/25.
//

import UIKit

class YearModel {
    
    var date: Date
    var progessModels:[CalendarProgessModel] = []
    
    init(date: Date) {
        self.date = date
        progessModels.append(CalendarProgessModel(date: date, .gregorian))
        progessModels.append(CalendarProgessModel(date: date, .chinese))
        progessModels.append(CalendarProgessModel(date: date, .hebrew))
        progessModels.append(CalendarProgessModel(date: date, .islamicCivil))
        
    }
    
    

}
