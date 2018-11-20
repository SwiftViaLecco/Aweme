//
//  LeccoPlayerView.swift
//  Aweme
//
//  Created by lecco on 2018/11/20.
//  Copyright © 2018 lecco. All rights reserved.
//

import UIKit
import AVFoundation

class LeccoPlayerView: UIView {
    open var player:AVPlayer
    var playerItem:AVPlayerItem
    var urlAsset:AVURLAsset
    var playerLayer:AVPlayerLayer
    
    init(frame:CGRect, url:URL) {
        self.urlAsset = AVURLAsset(url: url)
        self.playerItem = AVPlayerItem(asset: self.urlAsset)
        self.player = AVPlayer(playerItem: self.playerItem)
        self.playerLayer = AVPlayerLayer(player: self.player)
        self.playerLayer.frame = frame
        self.playerLayer.videoGravity = AVLayerVideoGravity.resizeAspect
        super.init(frame: frame)
        self.layer.insertSublayer(self.playerLayer, at: 0)
        self.player.play()
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
