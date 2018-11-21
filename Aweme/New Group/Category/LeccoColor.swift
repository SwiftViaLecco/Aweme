//
//  LeccoColor.swift
//  DouYinApp
//
//  Created by lecco on 2018/11/16.
//  Copyright © 2018 lecco. All rights reserved.
//

import UIKit
import DynamicColor

///color
enum LeccoColor:String {
    case k30c9c2 = "30c9c2"  //主打色，button 背景色
    case k666666 = "666666"
    case k333333 = "333333"
    case k999999 = "999999"
    case kf1f1f1 = "f1f1f1"
    case kffffff = "ffffff"
    case kc7c7c7 = "c7c7c7"
    case kdddddd = "dddddd"
    case kbbbbbb = "bbbbbb"
    case kf4f4f4 = "f4f4f4"
    case kf8f8f8 = "f8f8f8"
    case kb9bec5 = "b9bec5"  //禁用状态
    case kfb3159 = "FB3159"  //禁用状态
    
}

struct GradientPoint {
    var location: CGFloat
    var color: UIColor
}

extension UIColor {
    public static var k30c9c2:UIColor = UIColor(hexString: LeccoColor.k30c9c2.rawValue)
    public static var k666666:UIColor = UIColor(hexString: LeccoColor.k666666.rawValue)
    public static var k333333:UIColor = UIColor(hexString: LeccoColor.k333333.rawValue)
    public static var k999999:UIColor = UIColor(hexString: LeccoColor.k999999.rawValue)
    public static var kf1f1f1:UIColor = UIColor(hexString: LeccoColor.kf1f1f1.rawValue)
    public static var kffffff:UIColor = UIColor(hexString: LeccoColor.kffffff.rawValue)
    public static var kc7c7c7:UIColor = UIColor(hexString: LeccoColor.kc7c7c7.rawValue)
    public static var kdddddd:UIColor = UIColor(hexString: LeccoColor.kdddddd.rawValue)
    public static var kbbbbbb:UIColor = UIColor(hexString: LeccoColor.kbbbbbb.rawValue)
    public static var kf4f4f4:UIColor = UIColor(hexString: LeccoColor.kf4f4f4.rawValue)
    public static var kf8f8f8:UIColor = UIColor(hexString: LeccoColor.kf8f8f8.rawValue)
    public static var kb9bec5:UIColor = UIColor(hexString: LeccoColor.kb9bec5.rawValue)
    public static var kfb3159:UIColor = UIColor(hexString: LeccoColor.kfb3159.rawValue)
    
    //生成纯色图片
    func imageFromColor(_ size:CGSize) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(size)
        guard let context = UIGraphicsGetCurrentContext() else {
            print("can not get content when converting.")
            return nil
        }
        context.setFillColor(self.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        defer { UIGraphicsEndImageContext() }
        return image
    }
    
    //渐变颜色变图片
    class func imageFromGradientColors(gradientPoints:[GradientPoint]!, size:CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            print("can not get content when converting.")
            return nil
        }
        guard let gradient = CGGradient(colorSpace: CGColorSpaceCreateDeviceRGB(), colorComponents: gradientPoints.compactMap { $0.color.cgColor.components }.flatMap { $0 }, locations: gradientPoints.map { $0.location }, count: gradientPoints.count) else {
            print("can not get content when converting.")
            return nil
        }
        context.drawLinearGradient(gradient, start: CGPoint.zero, end: CGPoint(x: 0, y: size.height), options: CGGradientDrawingOptions())
        guard let image = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            print("can not get content when converting.")
            return nil
            
        }
        let gradidentImage = UIImage(cgImage: image)
        defer { UIGraphicsEndImageContext() }
        return gradidentImage
    }
    
}

