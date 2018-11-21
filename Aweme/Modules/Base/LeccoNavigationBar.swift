//
//  LeccoNavigationBar.swift
//  Aweme
//
//  Created by lecco on 2018/11/21.
//  Copyright © 2018 lecco. All rights reserved.
//

import UIKit

class LeccoNavigationBar: UIView {
    
    var backButton:UIButton = {
       let button = UIButton(frame: CGRect.zero)
        button.setImage(UIImage(named: "iconNaviBackWhite"), for: .normal)
        return button
    }()
    
    var titleLabel:UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont.leccoFont(size: 18)
        label.textColor = UIColor.kffffff
        return label
    }()
    
    var rightButton:UIButton = {
        let button = UIButton(frame: CGRect.zero)
        button.isHidden = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.backButton)
        self.addSubview(self.titleLabel)
        self.addSubview(self.rightButton)
        
        self.backButton.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(self).offset(0)
            make.size.equalTo(CGSize(width: kNavBarHeight, height: kNavBarHeight))
        }
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self).offset(0)
            make.centerY.equalTo(self.backButton)
        }
        
        self.rightButton.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(self).offset(0)
            make.height.equalTo(self.backButton.snp.height)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
