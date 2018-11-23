//
//  LeccoVideoListRequest.swift
//  Aweme
//
//  Created by lecco on 2018/11/23.
//  Copyright © 2018 lecco. All rights reserved.
//

import UIKit

class LeccoVideoListRequest: LeccoBaseRequest {
    var type:LeccoVideoListControllerType?
    var uid:String?
    var page:Int?
    var size:Int?
    
    static func findPostAwemesPaged(uid:String, page:Int, _ size:Int = 20, success:@escaping HttpSuccess, failure:@escaping HttpFailure) {
        let request = LeccoVideoListRequest()
        request.uid = uid
        request.page = page
        request.size = size
        LeccoNetworkManager.getRequest(urlPath: FIND_AWEME_POST_BY_PAGE_URL, request: request, success: { data in
            if let response = LeccoVideoListResonse.deserialize(from: data as? [String:Any]) {
                success(response)
            }
        }, failure: { error in
            failure(error)
        })
    }
    
    static func findFavoriteAwemesPaged(uid:String, page:Int, _ size:Int = 20, success:@escaping HttpSuccess, failure:@escaping HttpFailure) {
        let request = LeccoVideoListRequest()
        request.uid = uid
        request.page = page
        request.size = size
        LeccoNetworkManager.getRequest(urlPath: FIND_AWEME_FAVORITE_BY_PAGE_URL, request: request, success: { data in
            if let response = LeccoVideoListResonse.deserialize(from: data as? [String:Any]) {
                success(response)
            }
        }) { error in
            failure(error)
        }
    }
    
}
