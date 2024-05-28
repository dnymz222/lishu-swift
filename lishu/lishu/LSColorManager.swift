//
//  LSColorManager.swift
//  lishu
//
//  Created by xueping wang on 2024/3/22.
//

import UIKit

class LSColorManager {
    
    
    static let share: LSColorManager = .init()
    
    lazy var themeColor: UIColor = {
        
        let color = UIColor(named: "ThemeColor")
        return color ?? UIColor.clear
    }()
    
    
    lazy var cellBackgroundColor: UIColor = {
        
        let color = UIColor(named: "CellBackgroundColor")
        return color ?? UIColor.clear
    }()
    
    
    lazy var navColor: UIColor = {
        
        let color = UIColor(named: "NavColor")
        return color ?? UIColor.clear
    }()
    
    lazy var textBlackColor: UIColor = {
        
        let color = UIColor(named: "TextBlackColor")
        return color ?? UIColor.clear
    }()
    
    
    lazy var textDarkColor: UIColor = {
        
        let color = UIColor(named: "TextDarkColor")
        return color ?? UIColor.clear
    }()
    
    lazy var textFadeColor: UIColor = {
        
        let color = UIColor(named: "TextFadeColor")
        return color ?? UIColor.clear
    }()
  
    
    
    lazy var textHeaderColor: UIColor = {
        
        let color = UIColor(named: "TextHeaderColor")
        return color ?? UIColor.clear
    }()
    
    lazy var textHighLightColor: UIColor = {
        
        let color = UIColor(named: "TextHighLightColor")
        return color ?? UIColor.clear
    }()
    
    
    lazy var textLightColor: UIColor = {
        
        let color = UIColor(named: "TextLightColor")
        return color ?? UIColor.clear
    }()
    
    lazy var textNormalColor: UIColor = {
        
        let color = UIColor(named: "TextNormalColor")
        return color ?? UIColor.clear
    }()
    
    
    lazy var textSelectColor: UIColor = {
        
        let color = UIColor(named: "TextSelectColor")
        return color ?? UIColor.clear
    }()
    
    lazy var viewBackgroundColor: UIColor = {
        
        let color = UIColor(named: "ViewBackgroundColor")
        return color ?? UIColor.clear
    }()


    
    

}
