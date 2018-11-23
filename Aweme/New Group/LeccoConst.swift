//
//  LeccoConst.swift
//  DouYinApp
//
//  Created by lecco on 2018/11/16.
//  Copyright © 2018 lecco. All rights reserved.
//

import UIKit

/// iPhone设备
let kisIPhone = (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? true : false)
/// iPad设备
let kisIPad = (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad ? true : false)

/// iPhone4设备
let kisIPhone4 = (max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.height) < 568.0 ? true : false)
/// iPhone5设备
let kisIPhone5 = (max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.height) == 568.0 ? true : false)
/// iPhone6设备
let kisIPhone6 = (max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.height) == 667.0 ? true : false)
/// iPhone6Plus设备
let kisIPhone6P = (max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.height) == 736.0 ? true : false)
/// iPhoneX设备
let kisIPhoneX = (max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.height) == 812.0 ? true : false)
/// iPhoneXR设备
let kisIPhoneXR = (max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.height) == 828.0 ? true : false)
/// iPhoneXSMAX设备
let kisIPhoneXSMax = (max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.height) == 1242.0 ? true : false)

/// 是否是留海屏
let kisAboveIPhoneX = (max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.height) >= 812.0 ? true : false)

// MARK: - 尺寸信息
let kScreenFrame:CGRect = UIScreen.main.bounds
/// 全屏宽度
let kScreenWitdh = UIScreen.main.bounds.width
/// 全屏高度，不含状态栏高度
let kScreenHeight = UIScreen.main.bounds.height

/// tabbar切换视图控制器高度
let kSafeAreaBottomHeight:CGFloat = kisAboveIPhoneX ? 34.0 : 0.0
let kTabbarRealHeight:CGFloat = 49.0
let kTabbarHeight:CGFloat = kSafeAreaBottomHeight + kTabbarRealHeight
/// 搜索视图高度

/// 状态栏高度
let kStatusBarHeight    = kisAboveIPhoneX ? 40.0 : 20.0

/// 导航栏高度
let kNavBarHeight   =  44.0

///状态导航栏高度
let kStatusNavBarHeight   =  (kStatusBarHeight + kNavBarHeight)

// MARK: - 时间格式
enum TimeFormat:String
{
    case format_default            = "yyyy-MM-dd HH:mm:ss"
    case format_yyMdHm             = "yy-MM-dd HH:mm"
    case format_yyyyMdHm           = "yyyy-MM-dd HH:mm"
    case format_yMd                = "yyyy-MM-dd"
    case format_MdHms              = "MM-dd HH:mm:ss"
    case format_MdHm               = "MM-dd HH:mm"
    case format_Hms                = "HH:mm:ss"
    case format_Hm                 = "HH:mm"
    case format_Md                 = "MM-dd"
    case format_yyMd               = "yy-MM-dd"
    case format_YYMMdd             = "yyyyMMdd"
    case format_yyyyMdHms          = "yyyyMMddHHmmss"
    case format_yyyyMdHmsS         = "yyyy-MM-dd HH:mm:ss.SSS"
    case format_yyyyMMddHHmmssSSS  = "yyyyMMddHHmmssSSS"
    case format_yMdWithSlash       = "yyyy/MM/dd"
    case format_yM                 = "yyyy-MM"
    case format_yMdChangeSeparator = "yyyy.MM.dd"
}

