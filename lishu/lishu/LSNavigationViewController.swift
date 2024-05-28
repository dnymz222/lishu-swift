//
//  LSNavigationViewController.swift
//  lishu
//
//  Created by xueping on 2024/3/6.
//

import UIKit

class LSNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.systemBackground
       
        
        let appearance = UINavigationBarAppearance()
        // 背景色
        appearance.backgroundColor = LSColorManager.share.navColor
     
        self.navigationBar.tintColor = LSColorManager.share.textDarkColor
        self.navigationBar.isTranslucent = false
         
//        [appearance configureWithOpaqueBackground];
        // 去除导航栏阴影（如果不设置clear，导航栏底下会有一条阴影线）
//           appearance.shadowColor = [UIColor clearColor];
        // 字体颜色
        appearance.titleTextAttributes = [.foregroundColor: LSColorManager.share.textDarkColor]
        // 带scroll滑动的页面
//        if (@available(iOS 15.0, *)) {
         self.navigationBar.scrollEdgeAppearance = appearance
//        } else{
         self.navigationBar.standardAppearance = appearance
//        }
        
        

        
    }
    
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0{
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    


}
