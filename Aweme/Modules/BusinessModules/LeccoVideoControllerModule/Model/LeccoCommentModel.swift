//
//  LeccoCommentModel.swift
//  Aweme
//
//  Created by lecco on 2018/11/22.
//  Copyright © 2018 lecco. All rights reserved.
//

import UIKit

class LeccoCommentModel: LeccoBaseModel {
    var cid:String?
    var status:Int?
    var text:String?
    var digg_count:Int?
    var create_time:Int?
    var reply_id:String?
    var aweme_id:String?
    var user_digged:Int?
    var text_extra = [Any]()
    var user_type:String?
    var user:LeccoUserModel?
    var visitor:LeccoVisitorModel?
    
    var isTemp:Bool = false
    var taskId:Int?
}
