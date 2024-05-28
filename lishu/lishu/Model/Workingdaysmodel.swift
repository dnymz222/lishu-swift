//
//  Workingdaysmodel.swift
//  lishu
//
//  Created by xueping wang on 2024/5/18.
//

import UIKit

struct Workingdaysmodel: Decodable{

    let recordId: String
    let date: String
    let day: String
    let year: String
    let month: String
    let code: String
    let configuration: String
    let working_day: String
    let work_hours: String
    let public_holiday: String
    let public_holiday_description: String?
    let weekend_day: String
}
