//
//  LeccoAddFunctionView.swift
//  Aweme
//
//  Created by lecco on 2018/11/16.
//  Copyright © 2018 lecco. All rights reserved.
//

import UIKit
import RxSwift

let kFunctionSpace = 5.0

protocol LeccoAddFunctionViewDelegate {
    func leccoCloseButtonPressed(button:LeccoCloseButton) -> Void
    func leccoMusicButtonPressed(button:LeccoRollButton) -> Void
    func leccoFunctionButtonPressed(button:LeccoFunctionButton) -> Void
    func leccoRecordButtonPressed(button:LeccoShootButton) -> Void
    func leccoEndRecordButtonPressed(button:UIButton) -> Void
}

enum LeccoAddFunctionViewType {
    case start,recording,pause
}

class LeccoAddFunctionView: UIView {
    
    var functionViewType:LeccoAddFunctionViewType = .start {
        didSet {
            switch functionViewType {
            case .start:
                self.propButton.isHidden = false
                self.mediaButton.isHidden = false
                self.deleteButton.isHidden = true
                self.endRecordButton.isHidden = true
            case .recording:
                self.propButton.isHidden = true
                self.mediaButton.isHidden = true
                self.deleteButton.isHidden = true
                self.endRecordButton.isHidden = true
            case .pause:
                self.propButton.isHidden = true
                self.mediaButton.isHidden = true
                self.deleteButton.isHidden = false
                self.endRecordButton.isHidden = false
            }
        }
    }
    
    var delegate: LeccoAddFunctionViewDelegate?
   
    var disposeBag = DisposeBag()
    
    //顶部进度条
    var progressView = LeccoProgressView()
    //左侧关闭按钮
    var closeButton = LeccoCloseButton(frame: .zero)
    //音乐选择按钮
    var musicButton = LeccoRollButton(frame: .zero)
    //反转
    var filpButton = LeccoFunctionButton(frame: CGRect.zero, type: .Flip)
    //快慢速
    var speedButton = LeccoFunctionButton(frame: CGRect.zero, type: .Speed)
    //美化
    var beautifyButton = LeccoFunctionButton(frame: CGRect.zero, type: .Beautify)
    //快慢速
    var delayButton = LeccoFunctionButton(frame: CGRect.zero, type: .Delay)
    //more
    var moreButton = LeccoFunctionButton(frame: CGRect.zero, type: .More)
    
    
    //shootbutton
    var shootButton = LeccoShootButton()
    //start
    // 媒体
    var mediaButton = LeccoFunctionButton(frame: CGRect.zero, type: .Media)
    //道具
    var propButton = LeccoFunctionButton(frame: CGRect.zero, type: .Prop)
    
    //recording
    var deleteButton:UIButton = {
       let button = UIButton(frame: CGRect.zero)
        button.setImage(UIImage(named: "icShootingDelete"), for: .normal)
        return button
    }()
    
    var endRecordButton:UIButton = {
        let button = UIButton(frame: CGRect.zero)
        button.setImage(UIImage(named: "icon_nextstep"), for: .normal)
        button.layer.cornerRadius = 25.0
        button.backgroundColor = UIColor.kfb3159
        return button
    }()
    
    
    var recordSegmentView:LeccoRecordSegmentView = LeccoRecordSegmentView(frame: CGRect.zero)
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.progressView)
        self.addSubview(self.closeButton)
        self.addSubview(self.musicButton)
        self.musicButton.rollImageView.image = UIImage.init(named: "icMusicSmallC")
        self.musicButton.rollTitleLabel.text = "选择音乐"
        self.addSubview(self.filpButton)
        self.addSubview(self.speedButton)
        self.addSubview(self.beautifyButton)
        self.addSubview(self.delayButton)
        self.addSubview(self.moreButton)
        
        self.addSubview(self.recordSegmentView)
        self.addSubview(self.shootButton)

        self.addSubview(self.propButton)
        self.addSubview(self.mediaButton)
        
        self.addSubview(self.endRecordButton)
        self.addSubview(self.deleteButton)
        
        
        self.shootButton.shootState = .Stop
        
        self.progressView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.top.equalTo(self).offset(kStatusBarHeight-15)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(5)
        }
        self.closeButton.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.top.equalTo(self.progressView.snp.bottom).offset(10)
            make.width.equalTo(44)
            make.height.equalTo(self.closeButton.snp.width)
        }
        
        self.musicButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self.closeButton.snp.centerY)
            make.size.equalTo(CGSize(width: 150, height: 44))
        }
        
        self.filpButton.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(0)
            make.topMargin.equalTo(self.closeButton.snp.topMargin).offset(0)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        self.speedButton.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(0)
            make.top.equalTo(self.filpButton.snp.bottom).offset(kFunctionSpace)
            make.size.equalTo(self.filpButton.snp.size)
        }
        self.beautifyButton.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(0)
            make.top.equalTo(self.speedButton.snp.bottom).offset(kFunctionSpace)
            make.size.equalTo(self.filpButton.snp.size)
        }
        self.delayButton.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(0)
            make.top.equalTo(self.beautifyButton.snp.bottom).offset(kFunctionSpace)
            make.size.equalTo(self.filpButton.snp.size)
        }
        self.moreButton.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(0)
            make.top.equalTo(self.delayButton.snp.bottom).offset(kFunctionSpace)
            make.size.equalTo(self.filpButton.snp.size)
        }
        
        self.recordSegmentView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(-(kSafeAreaBottomHeight))
            make.height.equalTo(50)
        }
        
        self.shootButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.recordSegmentView.snp.top).offset(0)
            make.centerX.equalTo(self).offset(0)
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        //start
        self.propButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.shootButton)
            make.size.equalTo(CGSize(width: 60, height: 60))
            make.right.equalTo(self.shootButton.snp.left).offset(-25)
            
        }
        
        //start
        self.mediaButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.shootButton)
            make.left.equalTo(self.shootButton.snp.right).offset(25)
            make.size.equalTo(self.propButton.snp.size)
        }
        
        //recording
        self.deleteButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.shootButton)
            make.left.equalTo(self.shootButton.snp.right).offset(10)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        self.endRecordButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.shootButton)
            make.left.equalTo(self.deleteButton.snp.right).offset(10)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        self.closeButton.rx.tap.subscribe({ [weak self] _ in
            self?.delegate?.leccoCloseButtonPressed(button: (self?.closeButton)!)
        }).disposed(by: disposeBag)
        
        self.musicButton.rx.tap.subscribe({ [weak self] _ in
            self?.delegate?.leccoMusicButtonPressed(button: (self?.musicButton)!)
        }).disposed(by: disposeBag)
        
        self.shootButton.rx.tap.subscribe ({ [weak self] _ in
            self?.delegate?.leccoRecordButtonPressed(button: (self?.shootButton)!)
        }).disposed(by: disposeBag)
        
        //function
        self.filpButton.rx.tap.subscribe({ [weak self] _ in
            self?.delegate?.leccoFunctionButtonPressed(button: (self?.filpButton)!)
        }).disposed(by: disposeBag)
        
        self.speedButton.rx.tap.subscribe({ [weak self] _ in
            self?.delegate?.leccoFunctionButtonPressed(button: (self?.speedButton)!)
        }).disposed(by: disposeBag)
        
        self.beautifyButton.rx.tap.subscribe({ [weak self] _ in
            self?.delegate?.leccoFunctionButtonPressed(button: (self?.beautifyButton)!)
        }).disposed(by: disposeBag)
        
        self.delayButton.rx.tap.subscribe({ [weak self] _ in
            self?.delegate?.leccoFunctionButtonPressed(button: (self?.delayButton)!)
        }).disposed(by: disposeBag)
        
        self.moreButton.rx.tap.subscribe({ [weak self] _ in
            self?.delegate?.leccoFunctionButtonPressed(button: (self?.moreButton)!)
        }).disposed(by: disposeBag)
        
        self.endRecordButton.rx.tap.subscribe({ [weak self] _ in
            self?.delegate?.leccoEndRecordButtonPressed(button: (self?.endRecordButton)!)
        }).disposed(by: disposeBag)
        
        
        //init
        defer {
           self.functionViewType = .start
        }
        
        
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
