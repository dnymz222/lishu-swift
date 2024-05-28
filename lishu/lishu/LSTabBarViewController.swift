//
//  LSTabBarViewController.swift
//  lishu
//
//  Created by xueping on 2024/3/6.
//

import UIKit

class LSTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let currentvc =  LSTimeViewController()
      
        let currentNav = LSNavigationViewController(rootViewController: currentvc)

        let item0 = UITabBarItem(title: NSLocalizedString("tab_time", comment: ""), image: UIImage(named: "tab_shijian_normal"), selectedImage: UIImage(named: "tab_shijian_select")?.withRenderingMode(.alwaysOriginal))
        currentvc.tabBarItem = item0
        
      
        
       
        
        let dayVc = LSDayViewController()
        let dayNav = LSNavigationViewController(rootViewController: dayVc)
        let item1 = UITabBarItem(title: NSLocalizedString("tab_day", comment: ""), image: UIImage(named: "tab_day_normal"), selectedImage: UIImage(named: "tab_day_select")?.withRenderingMode(.alwaysOriginal))
        dayVc.tabBarItem = item1
       
        
        
        let monthVC = LSMonthViewController()
        let monthNav = LSNavigationViewController(rootViewController: monthVC)
        let item2 = UITabBarItem(title: NSLocalizedString("tab_month", comment: ""), image: UIImage(named: "tab_month_normal"), selectedImage: UIImage(named: "tab_month_select")?.withRenderingMode(.alwaysOriginal))
        monthVC.tabBarItem = item2
     
        
        let yearVC = LSYearViewController()
        let yearNav = LSNavigationViewController(rootViewController: yearVC)
        let item3 = UITabBarItem(title: NSLocalizedString("tab_year", comment: ""), image: UIImage(named: "tab_year_normal"), selectedImage: UIImage(named: "tab_year_select")?.withRenderingMode(.alwaysOriginal))
        yearVC.tabBarItem = item3
       
    
        
        let settingVc = LSSettingViewController()
        let settingNav = LSNavigationViewController(rootViewController: settingVc)
        let item4 = UITabBarItem(title: NSLocalizedString("tab_more", comment: ""), image: UIImage(named: "tab_more_normal"), selectedImage: UIImage(named: "tab_more_select")?.withRenderingMode(.alwaysOriginal))
        settingVc.tabBarItem = item4
        
 
        
       
        
        
        self.viewControllers = [currentNav,dayNav,monthNav,yearNav,settingNav]
        
        
        
        let appearance = UITabBarAppearance()
         
         // 背景色
        appearance.backgroundColor = LSColorManager.share.navColor
 
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: LSColorManager.share.textDarkColor,
        .font: UIFont.systemFont(ofSize: 11)
        ]
         //tabBaritem title未选中状态颜色
         appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: LSColorManager.share.textNormalColor,
            .font: UIFont.systemFont(ofSize: 11)
         ]
        appearance.inlineLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: LSColorManager.share.textDarkColor,
        .font: UIFont.systemFont(ofSize: 11)
        ]
         //tabBaritem title未选中状态颜色
         appearance.inlineLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: LSColorManager.share.textNormalColor,
            .font: UIFont.systemFont(ofSize: 11)
         ]
        
        self.tabBarItem.standardAppearance = appearance
        self.tabBar.standardAppearance = appearance
        
        if #available(iOS 15.0, *) {
            self.tabBar.scrollEdgeAppearance = appearance
            self.tabBarItem.scrollEdgeAppearance = appearance
        } else {
            // Fallback on earlier versions
        }
    
        
        self.tabBar.isTranslucent = false


        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
