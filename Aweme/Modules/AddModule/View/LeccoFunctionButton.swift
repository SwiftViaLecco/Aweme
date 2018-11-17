//
//  LeccoFunctionButton.swift
//  Aweme
//
//  Created by lecco on 2018/11/16.
//  Copyright © 2018 lecco. All rights reserved.
//

import UIKit

struct LeccoFunctionButtonInfo {
    var normalImage:String
    var selectedImage:String
    var title:String
    
    init(_ normalImage:String,_ selectedImage:String, _ title:String) {
        self.normalImage = normalImage
        self.selectedImage = selectedImage
        self.title = title
    }
}

enum LeccoFunctionButtonType {
    case Flip,Speed,Beautify,Delay,More,Flash,Default
    var rawValue: LeccoFunctionButtonInfo {
        switch self {
            case .Default:return LeccoFunctionButtonInfo("","","")
            case .Flip:return LeccoFunctionButtonInfo("icShootingFlip","icShootingFliped","翻转")
            case .Speed:return LeccoFunctionButtonInfo("icShootingFlip","icShootingFliped","快满速")
            case .Beautify:return LeccoFunctionButtonInfo("icShootingFlip","icShootingFliped","美化")
            case .Delay:return LeccoFunctionButtonInfo("icShootingFlip","icShootingFliped","倒计时")
            case .More:return LeccoFunctionButtonInfo("icShootingFlip","icShootingFliped","更多")
            case .Flash:return LeccoFunctionButtonInfo("icShootingFlip","icShootingFliped","闪光灯")
        }
    }
}

class LeccoFunctionButton: UIButton {
    
    var functionImageView:UIImageView = {
        let imageView = UIImageView.init(frame: CGRect.zero)
        return imageView
    }()
    var functionTitleLabel:UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        return label
    }()
    
    var funcType:LeccoFunctionButtonType = .Default
    
    override var isSelected: Bool {
        willSet {
        }
        
        didSet {
            print("changed from \(oldValue) to \(isSelected)")
            let buttonInfo = self.funcType.rawValue
            self.functionTitleLabel.text = buttonInfo.title
            self.functionImageView.image = UIImage(named: isSelected ? buttonInfo.selectedImage : buttonInfo.normalImage)
        }
    }
    
    
    init(frame: CGRect, type:LeccoFunctionButtonType) {
        super.init(frame: frame)
        
        self.addSubview(self.functionImageView)
        self.addSubview(self.functionTitleLabel)
        self.functionImageView.snp.makeConstraints { (make) in
            make.left.height.right.equalTo(self).offset(10)
            make.height.equalTo(self.functionImageView.snp.width)
        }
        self.functionTitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.functionImageView.snp.centerX)
            make.top.equalTo(self.functionImageView).offset(5)
        }
        
        self.funcType = type
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