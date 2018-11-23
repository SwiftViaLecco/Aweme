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

//notification
let StatusBarTouchBeginNotification:String = "StatusBarTouchBeginNotification"


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
    init(data:[LeccoAwemeModel], currentIndex:Int, page:Int, size:Int, awemeType:LeccoAwemeType, uid:String) {
        super.init(nibName: nil, bundle: nil)
        self.currentIndex = currentIndex
        self.pageIndex = page
        self.pageSize = size
        self.awemeType = awemeType
        self.uid = uid
        self.awemes = data
//        self.data.append(data[currentIndex])
        NotificationCenter.default.addObserver(self, selector: #selector(statusBarTouchBegin), name: NSNotification.Name(rawValue: StatusBarTouchBeginNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationBecomeActive), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        // Do any additional setup after loading the view.
    }
    
    func setUpView() {
        tableView = UITableView(frame: CGRect(x: 0, y: -kScreenHeight, width: kScreenWitdh, height: kScreenHeight * 5))
        tableView?.contentInset = UIEdgeInsets(top: kScreenHeight, left: 0, bottom: kScreenHeight * 3, right: 0);
        tableView?.backgroundColor = UIColor.clear
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.showsVerticalScrollIndicator = false
        tableView?.separatorStyle = .none
        if #available(iOS 11.0, *) {
            tableView?.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        tableView?.register(LeccoVideoListCell.classForCoder(), forCellReuseIdentifier: LeccoVideoListCell.leccoIdentifier())
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.view.addSubview(self.tableView!)
            self.data = self.awemes
            self.tableView?.reloadData()
            let curIndexPath = IndexPath.init(row: self.currentIndex, section: 0)
            self.tableView?.scrollToRow(at: curIndexPath, at: UITableView.ScrollPosition.middle, animated: false)
            self.addObserver(self, forKeyPath: "currentIndex", options: [.initial, .new], context: nil)
        }
    }
}

extension LeccoVideoListController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kScreenHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LeccoVideoListCell.leccoIdentifier(), for: indexPath)
        cell.backgroundColor = indexPath.row % 2 == 1 ? UIColor.red : UIColor.white
        return cell
    }

}

extension LeccoVideoListController:UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        DispatchQueue.main.async {
            let translatedPoint = scrollView.panGestureRecognizer.translation(in: scrollView)
            scrollView.panGestureRecognizer.isEnabled = false
            if translatedPoint.y < -50 && self.currentIndex < (self.data.count - 1) {
                self.currentIndex += 1
            }
            if translatedPoint.y > 50 && self.currentIndex > 0 {
                self.currentIndex -= 1
            }
            UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseOut, animations: {
                self.tableView?.scrollToRow(at: IndexPath.init(row: self.currentIndex, section: 0), at: UITableView.ScrollPosition.top, animated: false)
            }, completion: { finished in
                scrollView.panGestureRecognizer.isEnabled = true
            })
        }
    }
}

extension LeccoVideoListController {
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "currentIndex") {
//            isCurPlayerPause = false
//            weak var cell = tableView?.cellForRow(at: IndexPath.init(row: currentIndex, section: 0)) as? AwemeListCell
//            if cell?.isPlayerReady ?? false {
//                cell?.replay()
//            } else {
//                AVPlayerManager.shared().pauseAll()
//                cell?.onPlayerReady = {[weak self] in
//                    if let indexPath = self?.tableView?.indexPath(for: cell!) {
//                        if !(self?.isCurPlayerPause ?? true) && indexPath.row == self?.currentIndex {
//                            cell?.play()
//                        }
//                    }
//                }
//            }
        }else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    @objc func statusBarTouchBegin() {
        currentIndex = 0
    }
    
    @objc func applicationBecomeActive() {
        let cell = tableView?.cellForRow(at: IndexPath.init(row: currentIndex, section: 0)) as! LeccoVideoListCell
        if !isCurPlayerPause {
            //            cell.playerView.play()
        }
    }
    
    @objc func applicationEnterBackground() {
        let cell = tableView?.cellForRow(at: IndexPath.init(row: currentIndex, section: 0)) as! LeccoVideoListCell
        //        isCurPlayerPause = cell.playerView.rate() == 0 ? true :false
        //        cell.playerView.pause()
    }
}
