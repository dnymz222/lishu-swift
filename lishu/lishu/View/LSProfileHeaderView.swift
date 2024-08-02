//
//  LSProfileHeaderView.swift
//  lishu
//
//  Created by xueping wang on 2024/6/8.
//

import UIKit

class LSProfileHeaderView: UITableViewHeaderFooterView {
    
    lazy var iconView: UIImageView = {
        let iconV: UIImageView = UIImageView()
        iconV.contentMode = .scaleAspectFit
        iconV.layer.cornerRadius = 80
        iconV.layer.masksToBounds = true
        iconV.isUserInteractionEnabled = true
        iconV.backgroundColor = LSColorManager.share.cellBackgroundColor
        return iconV
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = LSColorManager.share.textDarkColor
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    
    lazy var codeLabel: UILabel = {
        let label = UILabel()
        label.textColor = LSColorManager.share.textDarkColor
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .right
        return label
    }()
    
    
    lazy var copyButton: UIButton = {
        let cButton: UIButton = UIButton(type:.custom)
        cButton.bounds = CGRect(x: 0, y: 0, width: 44, height: 44)
        cButton.setImage(UIImage(named: "fuzhi"), for: .normal)
        
        return cButton
    }()
    

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(iconView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(codeLabel)
        self.contentView.addSubview(copyButton)
        iconView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(12)
            make.width.height.equalTo(160)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.iconView.snp.bottom).offset(10)
            make.width.equalTo(240)
            make.height.equalTo(24)
        }
        
        
        codeLabel.snp.makeConstraints { make in
            make.right.equalTo(self.contentView.snp.centerX).offset(10)
            make.top.equalTo(self.nameLabel.snp.bottom).offset(10)
            make.width.equalTo(180)
            make.height.equalTo(24)
        }
        
        copyButton.snp.makeConstraints { make in
            make.left.equalTo(codeLabel.snp.right).offset(10)
            make.centerY.equalTo(codeLabel)
            make.width.height.equalTo(44)
        }
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func configNoLogin() {
        
        self.codeLabel.text = NSLocalizedString("my_code", comment: "")
        self.copyButton.setImage(nil, for: .normal)
        self.nameLabel.text = NSLocalizedString("not_login", comment: "")
        
    }
    
    
}
