//
//  LeccoAwemeModel.swift
//  Aweme
//
//  Created by lecco on 2018/11/22.
//  Copyright © 2018 lecco. All rights reserved.
//

import UIKit

class LeccoAwemeModel: LeccoBaseModel {
    var author:LeccoUserModel?
    var music:LeccoMusicModel?
    var cmt_swt:Bool?
    var video_text = [LeccoVideo_textModel]()
    var risk_infos:LeccoRisk_infosModel?
    var is_top:Int?
    var region:String?
    var user_digged:Int?
    var cha_list = [LeccoCha_listModel]()
    var is_ads:Bool?
    var bodydance_score:Int?
    var law_critical_country:Bool?
    var author_user_id:Int?
    var create_time:Int?
    var statistics:LeccoStatisticsModel?
    var video_labels = [LeccoVideo_labelsModel]()
    var sort_label:String?
    var descendants:LeccoDescendantsModel?
    var geofencing = [LeccoGeofencingModel]()
    var is_relieve:Bool?
    var status:LeccoStatusModel?
    var vr_type:Int?
    var aweme_type:Int?
    var aweme_id:String?
    var video:LeccoVideoModel?
    var is_pgcshow:Bool?
    var desc:String?
    var is_hash_tag:Int?
    var share_info:LeccoAweme_share_infoModel?
    var share_url:String?
    var scenario:Int?
    var label_top:LeccoLabel_topModel?
    var rate:Int?
    var can_play:Bool?
    var is_vr:Bool?
    var text_extra = [LeccoText_extraModel]()
}


class LeccoVideo_textModel: LeccoBaseModel {
}

class LeccoRisk_infosModel: LeccoBaseModel  {
    var warn:Bool?
    var content:String?
    var risk_sink:Bool?
    var type:Int?
}

class LeccoCha_listModel: LeccoBaseModel  {
    var author:LeccoUserModel?
    var user_count:Int?
    var schema:String?
    var sub_type:Int?
    var desc:String?
    var is_pgcshow:Bool?
    var cha_name:String?
    var type:Int?
    var cid:String?
}

class LeccoStatisticsModel: LeccoBaseModel  {
    var digg_count:Int?
    var aweme_id:Int?
    var share_count:Int?
    var play_count:Int?
    var comment_count:Int?
}

class LeccoVideo_labelsModel: LeccoBaseModel  {
}

class LeccoDescendantsModel: LeccoBaseModel  {
    var notify_msg:String?
    var platforms = [String]()
}

class LeccoStatusModel: LeccoBaseModel  {
    var allow_share:Bool?
    var private_status:Int?
    var is_delete:Bool?
    var with_goods:Bool?
    var is_private:Bool?
    var with_fusion_goods:Bool?
    var allow_comment:Bool?
}

class LeccoAweme_share_infoModel: LeccoBaseModel  {
    var share_weibo_desc:String?
    var share_title:String?
    var share_url:String?
    var share_desc:String?
}

class LeccoLabel_topModel: LeccoBaseModel  {
    var url_list = [String]()
    var uri:String?
}

class LeccoText_extraModel: LeccoBaseModel  {
}

