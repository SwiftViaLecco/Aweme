//
//  LeccoView.swift
//  Aweme
//
//  Created by lecco on 2018/11/22.
//  Copyright © 2018 lecco. All rights reserved.
//

import UIKit

extension UIView {
    
    open class func leccoIdentifier() -> String {
        return NSStringFromClass(self.classForCoder())
    }
}
