//
//  LeccoEditVideoController.swift
//  Aweme
//
//  Created by lecco on 2018/11/20.
//  Copyright © 2018 lecco. All rights reserved.
//

import UIKit

class LeccoEditVideoController: UIViewController {
    
    var videoPath:URL!
    var leccoPlayerView:LeccoPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.leccoPlayerView = LeccoPlayerView.init(frame: self.view.bounds, url: self.videoPath)
        self.view.addSubview(self.leccoPlayerView)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

}
