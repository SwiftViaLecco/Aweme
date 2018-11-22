//
//  LeccoVideoListController.swift
//  Aweme
//  视频列表
//  Created by lecco on 2018/11/22.
//  Copyright © 2018 lecco. All rights reserved.
//

import UIKit

enum LeccoAwemeType {
    case work
    case favorite
    case recommand
}

class LeccoVideoListController: LeccoBaseViewController {

    var tableView:UITableView?
    @objc dynamic var currentIndex:Int = 0
    var isCurPlayerPause:Bool = false
    var pageIndex:Int = 0
    var pageSize:Int = 21
    var awemeType:LeccoAwemeType?
    var uid:String?
    
    var data = [LeccoAwemeModel]()
    var awemes = [LeccoAwemeModel]()
//    var loadMore:LoadMoreControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
