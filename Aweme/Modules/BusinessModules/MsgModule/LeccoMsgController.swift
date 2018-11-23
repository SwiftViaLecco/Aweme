//
//  LeccoMsgController.swift
//  Aweme
//
//  Created by lecco on 2018/11/21.
//  Copyright © 2018 lecco. All rights reserved.
//

import UIKit

class LeccoMsgController: LeccoBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "消息"

        // Do any additional setup after loading the view.
    }
    
    
    //状态栏
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }

}
