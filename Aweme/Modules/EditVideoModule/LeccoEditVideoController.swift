//
//  LeccoEditVideoController.swift
//  Aweme
//
//  Created by lecco on 2018/11/20.
//  Copyright © 2018 lecco. All rights reserved.
//

import UIKit
import AVFoundation

class LeccoEditVideoController: LeccoBaseViewController {
    
    var videoPath:URL!
    var leccoPlayerView:LeccoPlayerView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Prepare Audio Session
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.leccoPlayerView = LeccoPlayerView.init(frame: self.view.bounds, url: self.videoPath)
        self.view.addSubview(self.leccoPlayerView)
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

}
