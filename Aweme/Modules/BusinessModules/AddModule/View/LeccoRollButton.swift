//
//  LeccoRollButton.swift
//  Aweme
//
//  Created by lecco on 2018/11/16.
//  Copyright © 2018 lecco. All rights reserved.
//

import UIKit

class LeccoRollButton: UIButton {
    
   open var rollImageView:UIImageView = {
        let imageView = UIImageView.init(frame: CGRect.zero)
        return imageView
    }()
   open var rollTitleLabel:UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        label.textColor = UIColor.kffffff
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.rollImageView)
        self.addSubview(self.rollTitleLabel)
        self.rollTitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX).offset(10)
            make.centerY.equalTo(self.snp.centerY)
        }
        self.rollImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.rollTitleLabel.snp.centerY)
            make.right.equalTo(self.rollTitleLabel.snp.left).offset(-5)
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
