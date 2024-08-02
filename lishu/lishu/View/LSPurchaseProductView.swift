//
//  LSPurchaseProductView.swift
//  lishu
//
//  Created by xueping wang on 2024/6/12.
//

import UIKit
import SnapKit


protocol LSPurchaseProductViewDelegate: NSObjectProtocol {
    
    func didSelectProductView(_ view: LSPurchaseProductView)
}


class LSPurchaseProductView: UIView {
    
    weak var delegate: LSPurchaseProductViewDelegate?
    
    lazy var checkButton: UIButton = {
        let cButton = UIButton(type:.custom)
        
        cButton.bounds = CGRect(x: 0, y: 0, width: 44, height: 44)
        
        cButton.setImage(UIImage(named: "weixuanzhong"), for: .normal)
        cButton.setImage(UIImage(named: "xuanzhong"), for: .selected)
        
        cButton.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        
        return cButton
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = LSColorManager.share.textDarkColor
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.checkButton)
        self.addSubview(self.priceLabel)
        
        self.backgroundColor = LSColorManager.share.cellBackgroundColor
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        
        
        self.checkButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(6)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(44)
        }
        
        self.priceLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(70)
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.height.equalTo(24)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapin))
        self.addGestureRecognizer(tap)
        
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc
    func buttonClick() {
        
        selectView()
    }
    
    @objc
    func tapin() {
        selectView()
    }
    
    func selectView() {
        if let delegate = self.delegate  {
            delegate.didSelectProductView(self)
        }
    }
}
