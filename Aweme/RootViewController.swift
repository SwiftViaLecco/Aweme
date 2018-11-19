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
class RootViewController: UIViewController {
    
    lazy var leccoTabbar:Segmentio = {
        let tabbar = Segmentio(frame: CGRect.zero)
        let content = [
            SegmentioItem(title: "首页", image: nil),
            SegmentioItem(title: "关注", image: nil),
            SegmentioItem(title: "发布", image: nil),
            SegmentioItem(title: "消息", image: nil),
            SegmentioItem(title: "我的", image: nil),
        ]
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
        tabbar.setup(content: content, style: SegmentioStyle.onlyLabel, options: options)
        
        return tabbar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIColor .imageFromGradientColors(gradientPoints: [GradientPoint(location: 0, color: UIColor.white),GradientPoint(location: 0.5, color: UIColor.black),GradientPoint(location: 1, color: UIColor.white)], size: CGSize(width: kScreenWitdh, height: kScreenHeight))
        let imageView = UIImageView(image: image!)
        self.view.addSubview(imageView)
        
        self.view.addSubview(self.leccoTabbar)
        self.leccoTabbar.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(self.view).offset(0)
            make.height.equalTo(kTabbarRealHeight)
            make.bottom.equalTo(self.view).offset(-kTabbarSafeHight)
        }
        self.leccoTabbar.selectedSegmentioIndex = 0
        
        self.leccoTabbar.valueDidChange = { segmentio, segmentIndex in
            guard segmentIndex == 2 else {
                return
            }
            
            self.present(LeccoAddViewController(), animated: true, completion: {
                
            })
            
        }
        
        
        
        
        

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
