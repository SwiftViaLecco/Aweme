//
//  LeccoRecordSegmentView.swift
//  Aweme
//
//  Created by lecco on 2018/11/21.
//  Copyright © 2018 lecco. All rights reserved.
//

import UIKit
import RxSwift

enum LeccoRecordSegmentViewType {
    case photo,tap,longPress
}

let kLeccoRecordSegmentButtonWidth = 80.0

class LeccoRecordSegmentView: UIView {
    var type:LeccoRecordSegmentViewType = .tap {
        didSet {
            self.setNeedsUpdateConstraints()
            UIView.animate(withDuration: 0.38) {
                switch self.type {
                case .photo:
                    self.tapRecordButton.snp.updateConstraints { (make) in
                        make.centerX.equalTo(self.circleView.snp.centerX).offset(kLeccoRecordSegmentButtonWidth)
                    }
                case .tap:
                    self.tapRecordButton.snp.updateConstraints { (make) in
                        make.centerX.equalTo(self.circleView.snp.centerX).offset(0)
                    }
                case .longPress:
                    self.tapRecordButton.snp.updateConstraints { (make) in
                        make.centerX.equalTo(self.circleView.snp.centerX).offset(-kLeccoRecordSegmentButtonWidth)
                    }
                    
                }
                self.layoutIfNeeded()
            }
            
        }
    }
    var takePhotoButton:UIButton = {
        let button = UIButton(frame: CGRect.zero)
        button.setTitle("拍照", for: .normal)
        button.titleLabel?.font =  UIFont.leccoFont(size: 15, type: .Medium)
        button.setTitleColor(UIColor.kdddddd, for: .normal)
        return button
    }()
    var tapRecordButton:UIButton = {
        let button = UIButton(frame: CGRect.zero)
        button.setTitle("单击拍", for: .normal)
        button.titleLabel?.font =  UIFont.leccoFont(size: 15, type: .Medium)
        button.setTitleColor(UIColor.kdddddd, for: .normal)
        return button
    }()
    var longPressButton:UIButton = {
        let button = UIButton(frame: CGRect.zero)
        button.setTitle("长按拍", for: .normal)
        button.titleLabel?.font = UIFont.leccoFont(size: 15, type: .Medium)
        button.setTitleColor(UIColor.kdddddd, for: .normal)
        return button
    }()
    private var circleView:UIView = {
        let circleView = UIView(frame: CGRect.zero)
        circleView.backgroundColor = UIColor.kdddddd
        circleView.layer.cornerRadius = 3.0
        return circleView
    }()
    var disposeBag = DisposeBag()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.type = .tap
        self.addSubview(self.circleView)
        self.addSubview(self.tapRecordButton)
        self.addSubview(self.takePhotoButton)
        self.addSubview(self.longPressButton)
        
        self.circleView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-3)
            make.size.equalTo(CGSize(width: 6, height: 6))
        }
        
        self.tapRecordButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.circleView.snp.top).offset(3)
            make.size.equalTo(CGSize(width: kLeccoRecordSegmentButtonWidth, height: 40))
            make.centerX.equalTo(self.circleView.snp.centerX)
        }
        
        self.takePhotoButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.tapRecordButton.snp.left).offset(0)
            make.centerY.equalTo(self.tapRecordButton.snp.centerY)
            make.size.equalTo(self.tapRecordButton.snp.size)
        }
        
        self.longPressButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.tapRecordButton.snp.right).offset(0)
            make.centerY.equalTo(self.tapRecordButton.snp.centerY)
            make.size.equalTo(self.tapRecordButton.snp.size)
        }
        
        self.tapRecordButton.rx.tap.subscribe({ [weak self] _ in
            self?.type = .tap
        }).disposed(by: disposeBag)
        
        self.takePhotoButton.rx.tap.subscribe({ [weak self] _ in
            self?.type = .photo
        }).disposed(by: disposeBag)
        
        self.longPressButton.rx.tap.subscribe({ [weak self] _ in
            self?.type = .longPress
        }).disposed(by: disposeBag)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
