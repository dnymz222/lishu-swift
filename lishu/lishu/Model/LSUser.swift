//
//  LSUser.swift
//  lishu
//
//  Created by xueping wang on 2024/6/7.
//

import Foundation


struct LSUser: Decodable  {
    let userId: Int
    var firstName: String
    var lastName: String
    var profile: String
    var inviteCode: String
    var email: String
    var phone: String
    
}
