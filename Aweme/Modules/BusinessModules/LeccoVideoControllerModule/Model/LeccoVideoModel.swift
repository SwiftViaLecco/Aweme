//
//  LeccoVideoModel.swift
//  Aweme
//
//  Created by lecco on 2018/11/22.
//  Copyright © 2018 lecco. All rights reserved.
//

import UIKit

class LeccoVideoModel: LeccoBaseModel {
    var dynamic_cover:LeccoCoverModel?
    var play_addr_lowbr:LeccoPlay_urlModel?
    var width:Int?
    var ratio:String?
    var play_addr:LeccoPlay_urlModel?
    var cover:LeccoCoverModel?
    var height:Int?
    var bit_rate = [LeccoBit_rateModel]()
    var origin_cover:LeccoCoverModel?
    var duration:Int?
    var download_addr:LeccoDownload_addrModel?
    var has_watermark:Bool?
}

class LeccoBit_rateModel: LeccoBaseModel {
    var bit_rate:Int?
    var gear_name:String?
    var quality_type:Int?
}

class LeccoDownload_addrModel: LeccoBaseModel {
    var url_list = [String]()
    var uri:String?
}
