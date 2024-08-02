//
//  LSUserManager.swift
//  lishu
//
//  Created by xueping wang on 2024/6/7.
//

import UIKit
import Supabase

class LSUserManager: NSObject {

    static let share: LSUserManager = .init()
    
    var isLogin: Bool = false
    
    var user: User?
    
    
    override init() {
        
    
    }
    
    func checkUser() {
        Task {
            
            if    let user = await LSSupabaseTool.share.currentUser() {
                self.isLogin = true
                self.user = user
            }
            
            
        }
    }
    
    func loginOut() {
           
    }
    
    
    
    
    
}
