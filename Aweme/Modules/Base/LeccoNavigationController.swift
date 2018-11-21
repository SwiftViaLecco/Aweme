//
//  LeccoNavigationController.swift
//  Aweme
//
//  Created by lecco on 2018/11/21.
//  Copyright © 2018 lecco. All rights reserved.
//

import UIKit

class LeccoNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // 重写这两个方法
    override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }
    
    override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
    

}
