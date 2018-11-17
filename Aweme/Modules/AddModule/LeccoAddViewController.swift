//
//  LeccoAddViewController.swift
//  Aweme
//
//  Created by lecco on 2018/11/16.
//  Copyright © 2018 lecco. All rights reserved.
//

import UIKit
import RxCocoa
import AVFoundation

class LeccoAddViewController: UIViewController {

    var functionView = LeccoAddFunctionView(frame: CGRect.zero)
    var captionSession = LeccoCaptureSession(sessionPreset: .High)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.captionSession.preView = self.view
        self.captionSession.startRunning()
        
        self.view.addSubview(self.functionView)
        self.functionView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(self.view).offset(0)
        }

        _ = functionView.closeButton.rx.tap.subscribe(onNext: {
            [weak self] in
            self?.dismiss(animated: true, completion: nil)

        })
        
    }


}
