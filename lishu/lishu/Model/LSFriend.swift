//
//  LSFriend.swift
//  lishu
//
//  Created by xueping wang on 2024/6/7.
//

import Foundation

struct LSFriend: Decodable{
    let friendId: Int
    let formUserId: Int
    let toUserId: Int
    var status: Int  // 0: request 1.accept 2.refuse 3.delete 4.block
    var requestTime: Int
    var acceptTime: Int
    
}
