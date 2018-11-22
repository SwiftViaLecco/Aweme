//
//  RootViewController.swift
//  DouYinApp
//
//  Created by lecco on 2018/11/16.
//  Copyright © 2018 lecco. All rights reserved.
//

import UIKit
import Segmentio
import SnapKit
class LeccoTabBarController: UIViewController {
    var viewControllers:[UINavigationController] = []
    var leccoTabbar:Segmentio!
    //点击拍照按钮时，selectedindex 恢复到原有index
    private var oldSegmentIndex:Int = -1
    private var selectedController:UINavigationController?
    private var selectedIndex:Int = -1 {
        didSet {
            if selectedIndex == oldValue {
                return
            }
            if selectedController != nil {
                selectedController?.view .removeFromSuperview()
            }
            let navVC = self.viewControllers[selectedIndex]
            navVC.view.frame = CGRect(x: 0, y: 0, width: kScreenWitdh, height: kScreenHeight)
            self.view.insertSubview(navVC.view, belowSubview: self.leccoTabbar)
            selectedController = navVC
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.k161824
        self.config()
        self.leccoTabbar.valueDidChange = { [weak self] (segmentio, segmentIndex) in
            guard segmentIndex != 2 else {
                self?.present(LeccoAddViewController(), animated: true, completion: {
                    self?.leccoTabbar.selectedSegmentioIndex = self?.oldSegmentIndex ?? -1
                })
                return
            }
            self?.oldSegmentIndex = segmentIndex
            guard segmentIndex >= 3 else {
                self?.selectedIndex = segmentIndex
                return
            }
            self?.selectedIndex = segmentIndex-1
            //
        }
         self.leccoTabbar.selectedSegmentioIndex = 0
        
        // Do any additional setup after loading the view.
    }
    
    func config() -> Void {
        self.leccoTabbar = {
            let tabbar = Segmentio(frame: CGRect.zero)
            var tabImages:[UIImage] = []
            let tabNames = ["首页","关注","发布","消息","我的"]
            let textColor = UIColor.kdddddd
            let recordImage = UIImage(named: "btn_home_add")!
            let size = recordImage.size
            let attr = [NSAttributedString.Key.font:UIFont.leccoFont(size: 18),NSAttributedString.Key.foregroundColor:UIColor.kffffff]
            let circular = false
            for (index,name) in tabNames.enumerated() {
                guard index != 2 else {
                    tabImages.append(recordImage)
                    continue
                }
                let image = UIImage.leccoImage(color: textColor, size: size, text: name, attr: attr, circular: circular) ?? UIImage()
                tabImages.append(image)
            }
            
            var content:[SegmentioItem] = []
            tabImages.forEach({ (image) in
                content.append(SegmentioItem(title:nil, image: image))
            })
            let options = SegmentioOptions(
                backgroundColor: .clear,
                segmentPosition: .fixed(maxVisibleItems: 5),
                scrollEnabled: true,
                indicatorOptions: SegmentioIndicatorOptions(type: .bottom, ratio: 0.5, height: 2, color: .white),
                horizontalSeparatorOptions: SegmentioHorizontalSeparatorOptions(type: .none, height: 0.5, color: UIColor.kdddddd),
                verticalSeparatorOptions: SegmentioVerticalSeparatorOptions(ratio: 0, color: UIColor.red),
                imageContentMode: .center,
                labelTextAlignment: .center,
                labelTextNumberOfLines:0,
                segmentStates: SegmentioStates(defaultState: SegmentioState(backgroundColor: .clear, titleFont: UIFont.leccoFont(size: 18), titleTextColor: UIColor.kdddddd),
                                               selectedState: SegmentioState(backgroundColor: .clear, titleFont: UIFont.leccoFont(size: 18), titleTextColor: UIColor.kffffff),
                                               highlightedState: SegmentioState(backgroundColor: .clear, titleFont: UIFont.leccoFont(size: 18), titleTextColor: UIColor.kffffff)),
                animationDuration:0.1
            )
            tabbar.setup(content: content, style: SegmentioStyle.onlyImage, options: options)
            return tabbar
        }()
        
        self.view.addSubview(self.leccoTabbar)
        self.leccoTabbar.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(self.view).offset(0)
            make.height.equalTo(kTabbarRealHeight)
            make.bottom.equalTo(self.view).offset(-kTabbarSafeHight)
        }
        
        //controller
        let homeVC = LeccoHomeController()
        let followVC = LeccoFollowController()
        let msgVC = LeccoMsgController()
        let mineVC = LeccoMineController()
        let controllers = [homeVC,followVC,msgVC,mineVC]
        self.viewControllers.removeAll()
        for controller in controllers {
            controller.leccoNavigationBarBackButtonIsHidden = true
            let navVC = UINavigationController(rootViewController: controller)
            self.viewControllers.append(navVC)
            self.addChild(navVC)
        }
    }
    
    override var childForStatusBarHidden: UIViewController? {
        return self.selectedController
    }
    
    override var childForStatusBarStyle: UIViewController? {
        return self.selectedController
    }


}
