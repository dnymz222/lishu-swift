//
//  LSNormalHeaderView.swift
//  lishu
//
//  Created by xueping wang on 2024/6/7.
//

import UIKit
import SnapKit

class LSNormalHeaderView: UITableViewHeaderFooterView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = LSColorManager.share.textDarkColor
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = LSColorManager.share.navColor
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
            make.height.equalTo(24)
            make.width.equalTo(240)
            
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
