//
//  LeccoBaseResponse.swift
//  Aweme
//
//  Created by lecco on 2018/11/23.
//  Copyright © 2018 lecco. All rights reserved.
//

import UIKit
import HandyJSON

class LeccoBaseResponse: NSObject, HandyJSON {
    var code:Int?
    var message:String?
    var has_more:Int = 0
    var total_count:Int = 0
    required override init() {
        
    }
}
