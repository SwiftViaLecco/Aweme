//
//  LeccoLeccoGroupChatModelModel.swift
//  Aweme
//
//  Created by lecco on 2018/11/22.
//  Copyright © 2018 lecco. All rights reserved.
//

import UIKit

class LeccoGroupChatModel: LeccoBaseModel {
    var id:String?
    var msg_type:String?
    var msg_content:String?
    var visitor:LeccoVisitorModel?
    var pic_original:LeccoPictureInfoModel?
    var pic_large:LeccoPictureInfoModel?
    var pic_medium:LeccoPictureInfoModel?
    var pic_thumbnail:LeccoPictureInfoModel?
    var create_time:Int?
    
    var taskId:Int?
    var isTemp:Bool = false
    var isFailed:Bool = false
    var isCompleted:Bool = false
    var percent:Float?
    var picImage:UIImage?
    var cellHeight:CGFloat = 0
    
    func createTimeChat() -> LeccoGroupChatModel {
        let timeChat = LeccoGroupChatModel.init()
        timeChat.msg_type = "time"
        timeChat.msg_content = Date.formatTime(timeInterval: TimeInterval(self.create_time ?? 0))
        timeChat.create_time = self.create_time
        timeChat.cellHeight = LeccoTimeCell.cellHeight(chat: timeChat)
        return timeChat
    }
    
    static func initImageChat(image:UIImage) -> LeccoGroupChatModel {
        let chat = LeccoGroupChatModel.init()
        chat.msg_type = "image"
        chat.isTemp = true
        chat.picImage = image
        let picInfo = LeccoPictureInfoModel.init()
        picInfo.width = image.size.width
        picInfo.height = image.size.height
        chat.pic_original = picInfo
        chat.pic_large = picInfo
        chat.pic_medium = picInfo
        chat.pic_thumbnail = picInfo
        return chat
    }
    
    
    static func initTextChat(text:String) -> LeccoGroupChatModel {
        let chat = LeccoGroupChatModel.init()
        chat.msg_type = "text"
        chat.isTemp = true
        chat.msg_content = text
        return chat
    }
    
    func updateTempImageChat(chat:LeccoGroupChatModel) {
        id = chat.id
        pic_original = chat.pic_original
        pic_large = chat.pic_large
        pic_medium = chat.pic_medium
        pic_thumbnail = chat.pic_thumbnail
        create_time = chat.create_time
        isTemp = true
        percent = 1.0
        isCompleted = true
        isFailed = false
    }
    
    func updateTempTextChat(chat:LeccoGroupChatModel) {
        id = chat.id
        create_time = chat.create_time
        isTemp = true
        isCompleted = true
        isFailed = false
    }
}
