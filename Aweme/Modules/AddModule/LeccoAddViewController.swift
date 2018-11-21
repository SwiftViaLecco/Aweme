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
import Photos

class LeccoAddViewController: LeccoBaseViewController {
    
    var functionView:LeccoAddFunctionView!
    private var _previewView: OpenGLPixelBufferView?
    private var _capturePipeline: RosyWriterCapturePipeline!
    
    private var _addedObservers: Bool = false
    private var _recording: Bool = false
    private var _backgroundRecordingID: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier(rawValue: 0)
    private var _allowedToUseGPU: Bool = false
    deinit {
        if _addedObservers {
            NotificationCenter.default.removeObserver(self, name: UIApplication.didEnterBackgroundNotification, object: UIApplication.shared)
            NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: UIApplication.shared)
            NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: UIDevice.current)
            UIDevice.current.endGeneratingDeviceOrientationNotifications()
        }
    }
    
    //MARK: - View lifecycle
    @objc func applicationDidEnterBackground() {
        // Avoid using the GPU in the background
        _allowedToUseGPU = false
        _capturePipeline?.renderingEnabled = false
        
        _capturePipeline?.stopRecording() // a no-op if we aren't recording
        
        // We reset the OpenGLPixelBufferView to ensure all resources have been cleared when going to the background.
        _previewView?.reset()
    }
    
    @objc func applicationWillEnterForeground() {
        _allowedToUseGPU = true
        _capturePipeline?.renderingEnabled = true
    }
    
    @objc func deviceOrientationDidChange() {
        let deviceOrientation = UIDevice.current.orientation
        // Update recording orientation if device changes to portrait or landscape orientation (but not face up/down)
        switch deviceOrientation {
        case .faceDown:break
        case .faceUp:break
        case .unknown:break
        default:
            _capturePipeline.recordingOrientation = AVCaptureVideoOrientation(rawValue: deviceOrientation.rawValue)!
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _capturePipeline.startRunning()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        _capturePipeline.stopRunning()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        _capturePipeline = RosyWriterCapturePipeline(delegate: self, callbackQueue: DispatchQueue.main)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.applicationDidEnterBackground),
                                               name: UIApplication.didEnterBackgroundNotification,
                                               object: UIApplication.shared)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.applicationWillEnterForeground),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: UIApplication.shared)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.deviceOrientationDidChange),
                                               name: UIDevice.orientationDidChangeNotification,
                                               object: UIDevice.current)
        
        // Keep track of changes to the device orientation so we can update the capture pipeline
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        _addedObservers = true
        // the willEnterForeground and didEnterBackground notifications are subsequently used to update _allowedToUseGPU
        _allowedToUseGPU = (UIApplication.shared.applicationState != .background)
        _capturePipeline.renderingEnabled = _allowedToUseGPU
        
        self.functionView = LeccoAddFunctionView(frame: CGRect.zero)
        self.functionView.delegate = self as LeccoAddFunctionViewDelegate
        self.view.addSubview(self.functionView)
        self.functionView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(self.view).offset(0)
        }
        
        
    }
    
    private func setupPreviewView() {
        // Set up GL view
        _previewView = OpenGLPixelBufferView(frame: CGRect.zero)
        _previewView!.autoresizingMask = [UIView.AutoresizingMask.flexibleHeight, UIView.AutoresizingMask.flexibleWidth]
        
        let currentInterfaceOrientation = UIApplication.shared.statusBarOrientation
        _previewView!.transform = _capturePipeline.transformFromVideoBufferOrientationToOrientation(AVCaptureVideoOrientation(rawValue: currentInterfaceOrientation.rawValue)!, withAutoMirroring: true) // Front camera preview should be mirrored
        
        self.view.insertSubview(_previewView!, belowSubview: self.functionView)
        var bounds = CGRect.zero
        bounds.size = self.view.convert(self.view.bounds, to: _previewView).size
        _previewView!.bounds = bounds
        _previewView!.center = CGPoint(x: self.view.bounds.size.width/2.0, y: self.view.bounds.size.height/2.0)
    }
    
    
    //MARK: Capture Session
    // These methods are synchronous
    
    private func recordingStartOrStop() {
        if _recording {
            _capturePipeline.stopRecording()
        } else {
            // Disable the idle timer while recording
            UIApplication.shared.isIdleTimerDisabled = true
            
            // Make sure we have time to finish saving the movie if the app is backgrounded during recording
            if UIDevice.current.isMultitaskingSupported {
                _backgroundRecordingID = UIApplication.shared.beginBackgroundTask(expirationHandler: {})
            }
            _capturePipeline.startRecording()
            _recording = true
        }
    }
    
    private func recordingStopped() {
        _recording = false
        UIApplication.shared.isIdleTimerDisabled = false
        UIApplication.shared.endBackgroundTask(_backgroundRecordingID)
        _backgroundRecordingID = UIBackgroundTaskIdentifier.invalid
    }
    
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}


extension LeccoAddViewController:RosyWriterCapturePipelineDelegate,LeccoAddFunctionViewDelegate {
    
    func leccoEndRecordButtonPressed(button: UIButton) {
        print("\(_capturePipeline.videoPathArray)")
        LeccoVideoMerge.leccoJoinVideos(urls: _capturePipeline.videoPathArray) { (url) in
            
            DispatchQueue.main.sync(execute: {
                guard url != nil else {
                    return
                }
                print("success merge: \(String(describing: url))")
                
                let editVideoVC = LeccoEditVideoController()
                editVideoVC.videoPath = url
                self.present(editVideoVC, animated: true, completion: nil)
            })
            
          
        }
    }
    
    func leccoCloseButtonPressed(button: LeccoCloseButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func leccoMusicButtonPressed(button: LeccoRollButton) {
        
    }
    
    func leccoFunctionButtonPressed(button: LeccoFunctionButton) {
        
    }
    
    func leccoRecordButtonPressed(button: LeccoShootButton) {
        switch button.shootState {
        case .Stop:
            button.shootState = .Shooting
            self.recordingStartOrStop()
            self.functionView.functionViewType = .recording
        case .Shooting:
            button.shootState = .Stop
            self.recordingStartOrStop()
            if _capturePipeline.videoPathArray.count > 0 {
                self.functionView.functionViewType = .pause
            } else {
                self.functionView.functionViewType = .start
            }
        }
        
       
        
    }
    
    func capturePipeline(_ capturePipeline: RosyWriterCapturePipeline, didStopRunningWithError error: Error) {
        self.functionView.shootButton.shootState = .Stop
        print(error)
    }
    
    func capturePipeline(_ capturePipeline: RosyWriterCapturePipeline, previewPixelBufferReadyForDisplay previewPixelBuffer: CVPixelBuffer) {
        if !_allowedToUseGPU {
            return
        }
        if _previewView == nil {
            self.setupPreviewView()
        }
        
        _previewView!.displayPixelBuffer(previewPixelBuffer)
    }
    
    func capturePipelineDidRunOutOfPreviewBuffers(_ capturePipeline: RosyWriterCapturePipeline) {
        if _allowedToUseGPU {
            _previewView?.flushPixelBufferCache()
        }
    }
    
    func capturePipelineRecordingDidStart(_ capturePipeline: RosyWriterCapturePipeline) {
        self.functionView.shootButton.shootState = .Shooting
    }
    
    func capturePipelineRecordingWillStop(_ capturePipeline: RosyWriterCapturePipeline) {
        self.functionView.shootButton.shootState = .Stop
    }
    
    func capturePipelineRecordingDidStop(_ capturePipeline: RosyWriterCapturePipeline) {
        self.recordingStopped()
    }
    
    func capturePipeline(_ capturePipeline: RosyWriterCapturePipeline, recordingDidFailWithError error: Error) {
        self.recordingStopped()
        print(error)
    }
    
   
   
   
   
    
    
}
