//
//  LSPremiumViewController.swift
//  lishu
//
//  Created by xueping wang on 2024/6/7.
//

import UIKit
import SwiftyStoreKit

class LSPremiumViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = LSColorManager.share.textDarkColor
        label.font = UIFont.boldSystemFont(ofSize:16)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.text = NSLocalizedString("elevationmap_pro", comment: "")
        
        return label
    }()
    
    
    lazy var sevicesLabel1: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = LSColorManager.share.textDarkColor
        label.font = UIFont.systemFont(ofSize:14)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.text = "1. " + NSLocalizedString("mountain_weather_forecast", comment: "")
        
        return label
    }()
    
    lazy var sevicesLabel2: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = LSColorManager.share.textDarkColor
        label.font = UIFont.systemFont(ofSize:14)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.text = "2. " + NSLocalizedString("unlock_all_tools", comment: "")
        
        return label
    }()
    
    
    lazy var sevicesLabel3: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = LSColorManager.share.textDarkColor
        label.font = UIFont.systemFont(ofSize:14)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.text = "2. " + NSLocalizedString("unlock_all_tools", comment: "")
        
        return label
    }()
    
    
    lazy var yearProductView: LSPurchaseProductView = {
        let yp =  LSPurchaseProductView()
        yp.delegate = self
        yp.tag = 0
        return yp
    }()
    
    
    lazy var monthProductView: LSPurchaseProductView = {
        let mp =  LSPurchaseProductView()
        mp.delegate = self
        mp.tag = 1
        return mp
    }()
    
    
    lazy var purchaseButton: UIButton = {
        
        let button = UIButton(type: .custom)
        button.backgroundColor =  LSColorManager.share.cellBackgroundColor

        button.setTitleColor(LSColorManager.share.textDarkColor, for: .normal)
        
        button.setTitle("Go Premium", for: .normal)
       
        
        return button
    }()
    
    

    var selectProductIndex: Int = 0


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = LSColorManager.share.viewBackgroundColor   
        
        
        self.view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(240)
            make.height.equalTo(40)
        }
        self.view.addSubview(self.sevicesLabel1)
        self.sevicesLabel1.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            make.width.equalTo(260)
            make.height.equalTo(40)
        }
        self.view.addSubview(self.sevicesLabel2)
        self.sevicesLabel2.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.top.equalTo(self.sevicesLabel1.snp.bottom).offset(8)
            make.width.equalTo(260)
            make.height.equalTo(40)
        }
        
  
        
        self.view.addSubview(self.sevicesLabel3)
        self.sevicesLabel3.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.top.equalTo(self.sevicesLabel2.snp.bottom).offset(8)
            make.width.equalTo(260)
            make.height.equalTo(40)
        }
        
        self.view.addSubview(self.yearProductView)
        
        self.yearProductView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.top.equalTo(self.sevicesLabel3.snp.bottom).offset(20)
            make.width.equalTo(260)
            make.height.equalTo(50)
        }
        
        self.view.addSubview(self.monthProductView)
        
        self.monthProductView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.top.equalTo(self.yearProductView.snp.bottom).offset(10)
            make.width.equalTo(260)
            make.height.equalTo(50)
        }
        
        self.view.addSubview(self.purchaseButton)
        
        
        self.purchaseButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.monthProductView.snp.bottom).offset(20)
       
            make.height.equalTo(50)
        }
        
        
        self.configProductIndex()
        
        
  
        
        SwiftyStoreKit.retrieveProductsInfo([LSPurchaseManager.annualProductId,LSPurchaseManager.monthProductId]) { result in
            DispatchQueue.main.async {
    
                for product in result.retrievedProducts {
                    
                    if product.productIdentifier == LSPurchaseManager.monthProductId {
                            let title =  String(format: NSLocalizedString("month_price", comment: ""), product.localizedPrice ?? "$1.99")
                        self.monthProductView.priceLabel.text = title
                          
                    } else if product.productIdentifier ==  LSPurchaseManager.annualProductId {
                            let title =  String(format: NSLocalizedString("annual_price", comment: ""), product.localizedPrice ?? "$19.99")
                        self.yearProductView.priceLabel.text = title
                           
                    }
                }
            }
        
        }
        
    

    }
    
    
    func configProductIndex() {
        if 0 == self.selectProductIndex {
            self.yearProductView.checkButton.isSelected = true
            self.monthProductView.checkButton.isSelected = false
        } else {
            self.yearProductView.checkButton.isSelected = false
            self.monthProductView.checkButton.isSelected = true
        }
    }
    

}

extension LSPremiumViewController: LSPurchaseProductViewDelegate {
    
    func didSelectProductView(_ view: LSPurchaseProductView) {
        self.selectProductIndex = view.tag
        self.configProductIndex()
    }
}
