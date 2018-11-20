//
//  LeccoEditVideoController.swift
//  Aweme
//
//  Created by lecco on 2018/11/20.
//  Copyright © 2018 lecco. All rights reserved.
//

import UIKit
import AVFoundation

class LeccoEditVideoController: UIViewController {
    
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
         NotificationCenter.default.addObserver(self, selector: #selector(self.playerItemDidPlayToEndTime(_:)), name: .AVPlayerItemDidPlayToEndTime, object: self.leccoPlayerView.player.currentItem)
    }
    
    @objc internal func playerItemDidPlayToEndTime(_ aNotification: Notification) {
            self.leccoPlayerView.player.seek(to: CMTime.zero)
            self.leccoPlayerView.player.play()
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

}
