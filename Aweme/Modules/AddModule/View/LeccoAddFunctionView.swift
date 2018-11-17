//
//  LeccoAddFunctionView.swift
//  Aweme
//
//  Created by lecco on 2018/11/16.
//  Copyright © 2018 lecco. All rights reserved.
//

import UIKit
import RxSwift

let kFunctionSpace = 5.0

class LeccoAddFunctionView: UIView {
    //顶部进度条
    var progressView = LeccoProgressView()
    //左侧关闭按钮
    var closeButton = LeccoCloseButton(frame: .zero)
    //音乐选择按钮
    var musicButton = LeccoRollButton(frame: .zero)
    //反转
    var filpButton = LeccoFunctionButton(frame: CGRect.zero, type: .Flip)
    //快慢速
    var speedButton = LeccoFunctionButton(frame: CGRect.zero, type: .Speed)
    //美化
    var beautifyButton = LeccoFunctionButton(frame: CGRect.zero, type: .Beautify)
    //快慢速
    var delayButton = LeccoFunctionButton(frame: CGRect.zero, type: .Delay)
    //more
    var moreButton = LeccoFunctionButton(frame: CGRect.zero, type: .More)
    
    //shootbutton
    var shootButton = LeccoShootButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.progressView)
        self.addSubview(self.closeButton)
        self.addSubview(self.musicButton)
        self.musicButton.rollImageView.image = UIImage.init(named: "icMusicSmallC")
        self.musicButton.rollTitleLabel.text = "选择音乐"
        self.addSubview(self.filpButton)
        self.addSubview(self.speedButton)
        self.addSubview(self.beautifyButton)
        self.addSubview(self.delayButton)
        self.addSubview(self.moreButton)
        self.addSubview(self.shootButton)
        self.shootButton.shootState = .Stop
        
        self.progressView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.top.equalTo(self).offset(kStatusBarHeight)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(5)
        }
        self.closeButton.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.top.equalTo(self.progressView.snp.bottom).offset(10)
            make.width.equalTo(44)
            make.height.equalTo(self.closeButton.snp.width)
        }
        
        self.musicButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self.closeButton.snp.centerY)
            make.size.equalTo(CGSize(width: 150, height: 44))
        }
        
        self.filpButton.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(0)
            make.centerY.equalTo(self.closeButton.snp.centerY)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        self.speedButton.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(0)
            make.top.equalTo(self.filpButton.snp.bottom).offset(kFunctionSpace)
            make.size.equalTo(self.filpButton.snp.size)
        }
        self.beautifyButton.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(0)
            make.top.equalTo(self.speedButton.snp.bottom).offset(kFunctionSpace)
            make.size.equalTo(self.filpButton.snp.size)
        }
        self.delayButton.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(0)
            make.top.equalTo(self.beautifyButton.snp.bottom).offset(kFunctionSpace)
            make.size.equalTo(self.filpButton.snp.size)
        }
        self.moreButton.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(0)
            make.top.equalTo(self.delayButton.snp.bottom).offset(kFunctionSpace)
            make.size.equalTo(self.filpButton.snp.size)
        }
        
        self.shootButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-(kTabbarHeight+10))
            make.centerX.equalTo(self).offset(0)
            make.size.equalTo(CGSize(width: 100, height: 100))
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
