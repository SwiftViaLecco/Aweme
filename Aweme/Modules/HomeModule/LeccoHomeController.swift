//
//  LeccoHomeController.swift
//  Aweme
//
//  Created by lecco on 2018/11/21.
//  Copyright © 2018 lecco. All rights reserved.
//

import UIKit


class LeccoHomeController: LeccoBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.leccoNavigationBarIsHidden = true
        // Do any additional setup after loading the view.
    }
    
    //状态栏
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
