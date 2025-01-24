//
//  LSAccountSettingViewController.swift
//  lishu
//
//  Created by xueping wang on 2024/6/7.
//

import UIKit

class LSAccountSettingViewController: UIViewController {
    
    
    lazy var logoutButton: UIButton = {
        
        let button = UIButton(type: .custom)
        button.backgroundColor =  LSColorManager.share.cellBackgroundColor
        
        button.setTitleColor(LSColorManager.share.textDarkColor, for: .normal)
        button.setTitle("log out", for: .normal)
        button.addTarget(self, action: #selector(logout), for: .touchUpInside)
       
        
        return button
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = LSColorManager.share.viewBackgroundColor
        
        self.view.addSubview(self.logoutButton)
        self.logoutButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.top.equalTo(self.view).offset(250)
            make.height.equalTo(44)
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @objc
    func logout()  {
        
//        if let user = LSUserManager.share.user {
//            Task{
//                await LSSupabaseTool.share.deleteAccount(user.id.uuidString)
//            }
//        }
        
        Task {
            await   LSSupabaseTool.share.logout()
        }
      
        
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
