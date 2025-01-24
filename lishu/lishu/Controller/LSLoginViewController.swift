//
//  LSLoginViewController.swift
//  lishu
//
//  Created by xueping wang on 2024/6/7.
//

import UIKit

class LSLoginViewController: UIViewController {
    
    lazy var signUpButton: UIButton = {
        
        let button = UIButton(type: .custom)
        button.backgroundColor =  LSColorManager.share.cellBackgroundColor
        
        button.setTitleColor(LSColorManager.share.textDarkColor, for: .normal)
        button.setTitle("Sign In", for: .normal)
        button.addTarget(self, action: #selector(singin), for: .touchUpInside)
       
        
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
        

        // Do any additional setup after loading the view.
    }
    
    @objc
    func singin()  {
        
                Task {
                    do {
                        try await   LSSupabaseTool.share.signin()
                    } catch {
    #if DEBUG
                        print("\(error)")
    #endif
                    }
                }
        }
    


}
