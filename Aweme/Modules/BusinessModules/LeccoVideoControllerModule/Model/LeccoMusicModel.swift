//
//  LeccoMusicModel.swift
//  Aweme
//
//  Created by lecco on 2018/11/22.
//  Copyright © 2018 lecco. All rights reserved.
//

import UIKit

class LeccoMusicModel: LeccoBaseModel {
    var extra:String?
    var cover_large:LeccoCoverModel?
    var id:Int?
    var cover_thumb:LeccoCoverModel?
    var mid:String?
    var cover_hd:LeccoCoverModel?
    var author:String?
    var user_count:Int?
    var play_url:LeccoPlay_urlModel?
    var cover_medium:LeccoCoverModel?
    var id_str:String?
    var title:String?
    var offline_desc:String?
    var is_restricted:Bool?
    var schema_url:String?
    var source_platform:Int?
    var duration:Int?
    var status:Int?
    var is_original:Bool?
}

class LeccoCoverModel: LeccoBaseModel {
    var url_list = [String]()
    var uri:String?
}

class LeccoPlay_urlModel: LeccoBaseModel {
    var url_list = [String]()
    var uri:String?
}
