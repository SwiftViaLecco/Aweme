//
//  LeccoCloseButton.swift
//  Aweme
//
//  Created by lecco on 2018/11/16.
//  Copyright © 2018 lecco. All rights reserved.
//

import UIKit

class LeccoCloseButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setImage(UIImage(named: "icShootingClose"), for: .normal)
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
