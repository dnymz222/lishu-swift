//
//  LSAlmanac.swift
//  lishu
//
//  Created by xueping wang on 2024/6/7.
//

import Foundation

struct LSAlmanac: Decodable {
    let userId: Int
    let calendarFirst: Int
    let calendarSecond: Int
    let holidayFirst: String
    let holidaySecond: String
    let location: String
    
}
