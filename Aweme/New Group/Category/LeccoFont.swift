//
//  LeccoFont.swift
//  DouYinApp
//
//  Created by lecco on 2018/11/16.
//  Copyright © 2018 lecco. All rights reserved.
//

import UIKit

enum LeccoFontType:String {
    case Ultralight = "PingFangSC-Ultralight"
    case Regular = "PingFangSC-Regular"
    case Semibold = "PingFangSC-Semibold"
    case Thin = "PingFangSC-Thin"
    case Light = "PingFangSC-Light"
    case Medium = "PingFangSC-Medium"
    
}


extension UIFont {
   class func leccoFont(size:CGFloat,type:LeccoFontType) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
    
   class func leccoFont(size:CGFloat) -> UIFont {
       return self.leccoFont(size: size, type: .Regular)
    }
}
