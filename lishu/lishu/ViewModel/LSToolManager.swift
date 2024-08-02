//
//  LSToolManager.swift
//  lishu
//
//  Created by xueping wang on 2024/6/8.
//

import UIKit
import CryptoSwift

class LSToolManager {
    
    static let share: LSToolManager = .init()
    
    let keys: [UInt8] = [83, 57, 75, 53, 77, 78, 81, 90, 82, 71, 88, 85, 74, 65, 54, 67, 72, 89, 68, 76, 69, 50, 52, 55, 51, 66, 84, 87, 80, 56, 70, 86]
    
    var aes: AES?
    
    init() {
        do {
            self.aes = try AES(key: self.keys, blockMode: ECB())
        } catch {
            
        }
    }
    
    func generateUserCode(_ userId: Int) -> String{
        
        let userNumber = userId
        
        let list:[String] = ["S", "9", "K", "5", "M", "N", "Q", "Z", "R", "G", "X", "U", "J", "A", "6", "C", "H", "Y", "D", "L", "E", "2", "4", "7", "3", "B", "T", "W", "P", "8", "F", "V"]

        let b =  log2(CGFloat(userNumber))
        var c = Int(ceil(Double(b / 5.0)))
        if userNumber < mutipleThirtyTwo(c) {
            
        } else {
            c = c + 1
        }
        
        var result: String = ""
        for j in 0..<c {
            let i =  c - j
            let left = userNumber % mutipleThirtyTwo(i)
            let v = left / mutipleThirtyTwo(i - 1)
            result = result + list[v]
        }

        return result
        
    }
    
    
    
    func mutipleThirtyTwo(_ count: Int) -> Int {
        
        var v : Int = 1
        for _ in 0..<count {
            
            v = v * 32
        }
        return v
    }
    
    func decryptText(_ text: String)  -> String{
        
        
        do {
            guard let data = Data(base64Encoded: text, options: Data.Base64DecodingOptions(rawValue: 0)),
                  let aes = self.aes else { return ""}
            let array = try aes.decrypt(data.bytes)
            
          let  resultData = Data(bytes: array, count: array.count)
            
          
            guard let string =  String(data: resultData, encoding: .utf8) else {
                return String()
            }
            return string

        } catch {
            return ""
        }
    }

}
