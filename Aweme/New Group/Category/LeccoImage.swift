//
//  LeccoImage.swift
//  Aweme
//
//  Created by lecco on 2018/11/21.
//  Copyright © 2018 lecco. All rights reserved.
//

import UIKit

extension UIImage {
    class func leccoImage(color:UIColor,size:CGSize,text:String,attr:[NSAttributedString.Key:Any],circular:Bool) -> UIImage? {
        guard size.width != 0 && size.height != 0 else {
            return nil
        }
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        if circular {
            let path = CGPath(ellipseIn: rect, transform: nil)
            context.addPath(path)
            context.clip()
        }
        //color
        context.setFillColor(UIColor.clear.cgColor)
        context.fill(rect)
        //text
        let textSize = text.size(withAttributes:attr)
        text.draw(in: CGRect(x: (size.width - textSize.width) / 2.0, y: (size.height - textSize.height) / 2.0, width: textSize.width, height: textSize.height), withAttributes: attr)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}
