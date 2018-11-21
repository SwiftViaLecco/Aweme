//
//  LeccoShootButton.swift
//  Aweme
//
//  Created by lecco on 2018/11/17.
//  Copyright © 2018年 lecco. All rights reserved.
//

import UIKit

enum LeccoShootButtonState:NSInteger {
    case Stop = 0
    case Shooting = 1
}

class LeccoShootButton: UIButton {
    var centerView:UIView = {
       let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor.kfb3159
        view.layer.cornerRadius = 60/2.0
        view.isUserInteractionEnabled = false
        return view
    }()
    
    var outeRingLayer:CAShapeLayer  = {
        let bezierPath = UIBezierPath(arcCenter: CGPoint(x: 40, y: 40), radius: 35, startAngle: 0, endAngle: .pi * 2, clockwise:true)
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.kfb3159.withAlphaComponent(0.3).cgColor
        layer.lineWidth = 5.0
        layer.path = bezierPath.cgPath
        return layer
    }()
    
    var shootState:LeccoShootButtonState = .Stop {
        didSet {
            switch shootState {
            case .Stop:
                self .setTitle("拍摄", for: .normal)
            case .Shooting:
                self .setTitle("停止", for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.centerView)
        self.centerView.snp.makeConstraints { (make) in
            make.center.equalTo(self.snp.center)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        self.layer.addSublayer(self.outeRingLayer)
       
       
    }
    
    func circlePathWithCenter(center: CGPoint, radius: CGFloat) -> UIBezierPath {
        let circlePath = UIBezierPath()
        circlePath.addArc(withCenter: center, radius: radius, startAngle: -.pi, endAngle: -.pi/2, clockwise: true)
        circlePath.addArc(withCenter: center, radius: radius, startAngle: -.pi/2, endAngle: 0, clockwise: true)
        circlePath.addArc(withCenter: center, radius: radius, startAngle: 0, endAngle: .pi/2, clockwise: true)
        circlePath.addArc(withCenter: center, radius: radius, startAngle: .pi/2, endAngle:.pi, clockwise: true)
        circlePath.close()
        return circlePath
    }
    
    func squarePathWithCenter(center: CGPoint, side: CGFloat) -> UIBezierPath {
        let squarePath = UIBezierPath()
        let startX = center.x - side / 2
        let startY = center.y - side / 2
        squarePath.move(to: CGPoint(x: startX, y: startY))
        squarePath.addLine(to: squarePath.currentPoint)
        squarePath.addLine(to: CGPoint(x: startX + side, y: startY))
        squarePath.addLine(to: squarePath.currentPoint)
        squarePath.addLine(to: CGPoint(x: startX + side, y: startY + side))
        squarePath.addLine(to: squarePath.currentPoint)
        squarePath.addLine(to: CGPoint(x: startX, y: startY + side))
        squarePath.addLine(to: squarePath.currentPoint)
        squarePath.close()
        return squarePath
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
