//
//  LSWKViewController.swift
//  lishu
//
//  Created by xueping wang on 2024/5/19.
//

import UIKit
import WebKit

class LSWKViewController: UIViewController {
    
    var navTitle: String?
    var url: URL?
    
    lazy var wkview: WKWebView = {
        var config = WKWebViewConfiguration()
        config.selectionGranularity = .dynamic
        
        var preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = false
        config.preferences = preferences
        
        let wk = WKWebView(frame: self.view.frame, configuration: config)
        return wk
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = LSColorManager.share.viewBackgroundColor
        
        self.view.addSubview(wkview)
        wkview.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        if let navTitle = self.navTitle {
            self.navigationItem.title = navTitle
        }
        if let url = self.url {
            self.wkview.load(URLRequest(url: url))
        }


    }
    


}
