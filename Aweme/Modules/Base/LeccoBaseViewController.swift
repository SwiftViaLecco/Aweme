//
//  LeccoBaseViewController.swift
//  Aweme
//
//  Created by lecco on 2018/11/21.
//  Copyright © 2018 lecco. All rights reserved.
//

import UIKit

class LeccoBaseViewController: UIViewController {
    
    open var leccoNavigationBar:LeccoNavigationBar = {
       let navigationBar = LeccoNavigationBar(frame: CGRect.zero)
        return navigationBar
    }()
    
    override var title: String? {
        didSet {
            self.leccoNavigationBar.titleLabel.text = title
        }
    }
    
    open var leccoNavigationBarIsHidden:Bool = false {
        didSet {
            self.leccoNavigationBar.isHidden = leccoNavigationBarIsHidden
        }
    }
    
    open var leccoNavigationBarBackButtonIsHidden:Bool = false {
        didSet {
            self.leccoNavigationBar.backButton.isHidden = leccoNavigationBarBackButtonIsHidden
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sh_prefersNavigationBarHidden = true
        self.view.addSubview(self.leccoNavigationBar)
        self.leccoNavigationBar.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self.view)
            make.height.equalTo(kStatusNavBarHeight)
        }
        defer {
            self.leccoNavigationBarIsHidden = false
        }
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
