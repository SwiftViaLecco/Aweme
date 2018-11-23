//
//  LeccoLeccoVisitorModelModel.swift
//  Aweme
//
//  Created by lecco on 2018/11/22.
//  Copyright © 2018 lecco. All rights reserved.
//

import UIKit

class LeccoVisitorModel: LeccoBaseModel {
    var uid:String?
    var udid:String?
    var avatar_thumbnail:LeccoPictureInfoModel?
    var avatar_medium:LeccoPictureInfoModel?
    var avatar_large:LeccoPictureInfoModel?
    
    static func write(LeccoVisitorModel:LeccoVisitorModel) {
        let dic = LeccoVisitorModel.toJSON()
        let defaults = UserDefaults.standard
        defaults.set(dic, forKey: "LeccoVisitorModel")
        defaults.synchronize()
    }
    
    static func read() ->LeccoVisitorModel {
        let defaults = UserDefaults.standard
        let dic = defaults.object(forKey: "LeccoVisitorModel") as! [String:Any]
        let leccoVisitorModel = LeccoVisitorModel.deserialize(from: dic)
        return leccoVisitorModel!
    }
    
    static func formatUDID(udid:String) -> String {
        
        if udid.count < 8 {
            return "************"
        }
        return udid.substring(location: 0, length:4) + "****" + udid.substring(location: udid.count - 4, length:4)
    }
}
