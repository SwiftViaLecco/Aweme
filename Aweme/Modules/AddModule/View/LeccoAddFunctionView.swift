//
//  LeccoAddFunctionView.swift
//  Aweme
//
//  Created by lecco on 2018/11/16.
//  Copyright © 2018 lecco. All rights reserved.
//

import UIKit
import RxSwift

class LeccoAddFunctionView: UIView {
    
    var progressView = LeccoProgressView()
    var closeButton = LeccoCloseButton(frame: .zero)
    var musicButton = LeccoRollButton(frame: .zero)
    var filpButton = LeccoFunctionButton(frame: CGRect.zero, type: .Flip)

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.progressView)
        self.addSubview(self.closeButton)
        self.addSubview(self.musicButton)
        self.addSubview(self.filpButton)
        
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
