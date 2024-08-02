//
//  LSKeyManager.swift
//  lishu
//
//  Created by xueping wang on 2024/3/24.
//

import Foundation
import StoreKit

class LSKeyManager  {

    
    static let share: LSKeyManager = .init()
    

    
    static let appId: String = "1281770398"
    static let isTwelveKey: String = "isTwelveKey"
    
    var isTwelve: Bool = false
    
    init() {
        
    }
    
    func configTwelve(_ twelve: Bool) {
        self.isTwelve = twelve;
    }
    
    
    func isChina() -> Bool {
        #if DEBUG
        #else
           if let country = SKPaymentQueue.default().storefront?.countryCode {
               if country == "CHN" {
                   return true
               }
           }

           
        if #available(iOS 16, *) {
            if let localCode = Locale.current.language.region?.identifier {
                if localCode == "CN" {
                    return true
                }
            }
        } else {
            // Fallback on earlier versions
        }
        #endif
        
           
           let language: String = NSLocalizedString("language", comment: "")
           if language == "zh-cn" {
               return true
           }

           return false
           
       }
   
   
    
    
    
    
}
