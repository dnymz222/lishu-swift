//
//  LSRegisterViewController.swift
//  lishu
//
//  Created by xueping wang on 2024/6/7.
//

import UIKit

class LSRegisterViewController: UIViewController {
    
    lazy var signUpButton: UIButton = {
        
        let button = UIButton(type: .custom)
        button.backgroundColor =  LSColorManager.share.cellBackgroundColor
        
        button.setTitleColor(LSColorManager.share.textDarkColor, for: .normal)
        button.setTitle("Sign Up", for: .normal)
        button.addTarget(self, action: #selector(singup), for: .touchUpInside)
       
        
        return button
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = LSColorManager.share.viewBackgroundColor   
    
        self.view.addSubview(self.signUpButton)
        self.signUpButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.top.equalTo(self.view).offset(250)
            make.height.equalTo(44)
        }
        
        
        
    
    }
    
    
    
    @objc
    func singup()  {
        

            
                Task {
                    do {
                        try await   LSSupabaseTool.share.signup()
                    } catch {
    #if DEBUG
                        print("\(error)")
    #endif
                    }
                }
        }
        

    
    

}
