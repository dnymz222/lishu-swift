//
//  LSVipUser.swift
//  lishu
//
//  Created by xueping wang on 2024/6/12.
//

import UIKit

struct LSVipUser: Decodable{
    let userId: Int
    var proType: Int  // 0:  1: month 2: annual
    var startTime: Double
    var expireTime: Double
    
    
}
