//
//  LeccoShootButton.swift
//  Aweme
//
//  Created by lecco on 2018/11/17.
//  Copyright © 2018年 lecco. All rights reserved.
//

import UIKit

enum LeccoShootButtonState:NSInteger {
    case Stop = 0
    case Shooting = 1
}

class LeccoShootButton: UIButton {
    
    var shootState:LeccoShootButtonState = .Stop {
        didSet {
            switch shootState {
            case .Stop:
                self .setTitle("拍摄", for: .normal)
            case .Shooting:
                self .setTitle("停止", for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _ = self.rx.tap.subscribe(onNext: { [weak self] in
            if self?.shootState == .Stop {
                self?.shootState = .Shooting
            } else {
                self?.shootState = .Stop
            }
            
        })
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
