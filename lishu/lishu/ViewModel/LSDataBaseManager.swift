//
//  LSDataBaseManager.swift
//  lishu
//
//  Created by xueping wang on 2024/5/25.
//

import UIKit
import GRDB

class LSDataBaseManager {
    
    static let share: LSDataBaseManager = .init()
    
    
    var dataBaseQueue: DatabaseQueue?
    
    init() {
        guard let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first as? NSString else {
          
            return
        }
        
        do {
            
            let dbpath = path.appendingPathComponent("data.db")
           
            let config = Configuration()
            
            try self.dataBaseQueue = DatabaseQueue(path: dbpath ,configuration: config)
            
            createTable()
            
            
        } catch {
            
            
        }
    }
    
    func createTable() {
        
        
    }

}
