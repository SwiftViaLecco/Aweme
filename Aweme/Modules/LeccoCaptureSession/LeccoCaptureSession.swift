//
//  LeccoCaptureSession.swift
//  Aweme
//
//  Created by lecco on 2018/11/17.
//  Copyright © 2018 lecco. All rights reserved.
//

import UIKit
import AVFoundation

enum LeccoCaptureSessionPreset:NSInteger {
    case High = 0
    case Medium = 1
    case Low = 2
    
    func degradePreset() -> LeccoCaptureSessionPreset {
        switch self {
        case .High: return .Medium
        case .Medium: return .Low
        case .Low: return .Low
        }
    }
    
    func preset() -> AVCaptureSession.Preset {
        switch self {
        case .High: return AVCaptureSession.Preset.high
        case .Medium: return AVCaptureSession.Preset.medium
        case .Low: return AVCaptureSession.Preset.low
        }
    }
}


class LeccoCaptureSession:NSObject {
    
    var session:AVCaptureSession = AVCaptureSession()
    var sessionPreset:LeccoCaptureSessionPreset = .High {
        didSet {
            guard self.session.canSetSessionPreset(sessionPreset.preset()) else {
                self.sessionPreset = sessionPreset.degradePreset()
                return
            }
            self.session.sessionPreset = sessionPreset.preset()
        }
    }
    var videoDevice:AVCaptureDevice!
    var audioDevice:AVCaptureDevice!
    var videoDeviceInput:AVCaptureDeviceInput!
    var audioDeviceInput:AVCaptureDeviceInput!
    var videoDeviceOutput:AVCaptureVideoDataOutput!
    var audioDeviceOutput:AVCaptureAudioDataOutput!
    open var preViewLayer:AVCaptureVideoPreviewLayer!
    var preView:UIView! {
        didSet {
            if (self.preViewLayer == nil) {
                self.preViewLayer = AVCaptureVideoPreviewLayer(session: self.session)
                self.preViewLayer?.frame = self.preView.bounds
                self.preViewLayer?.connection?.videoOrientation = self.videoDeviceOutput.connection(with: .video)?.videoOrientation ?? .portrait
                self.preViewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
                self.preViewLayer?.position = CGPoint(x: kScreenWitdh * 0.5, y: kScreenHeight * 0.5)
                let layer = self.preView.layer
                self.preViewLayer.backgroundColor = UIColor.red.cgColor
                layer.masksToBounds = true
                layer .addSublayer(self.preViewLayer)
            }
        }
    }
    
    func startRunning() -> Void {
        self.session.startRunning()
    }
    
    func stopRunning() -> Void {
        guard self.session.isRunning else {
            return
        }
        self.session.stopRunning()
    }
    
    
    init(sessionPreset:LeccoCaptureSessionPreset) {
        super.init()
        self.sessionPreset = sessionPreset
        self.config()
    }
    
    func config() -> Void {
        
        self.session.beginConfiguration()
        defer {
            self.session.commitConfiguration()
        }
        
        //视频相关
       guard let _videoDevice = AVCaptureDevice.default(for: .video) else {
            print("init videoDevice failed")
            return
        }
        self.videoDevice = _videoDevice
        
        guard let _videoDeviceInput = try? AVCaptureDeviceInput(device: self.videoDevice) else {
            print("init videoDeviceInput failed")
            return
        }
        self.videoDeviceInput = _videoDeviceInput
        guard self.session.canAddInput(self.videoDeviceInput) else {
            print("init canAddOutput failed")
            return
        }
        self.session.addInput(self.videoDeviceInput)

        self.videoDeviceOutput = AVCaptureVideoDataOutput()
        self.videoDeviceOutput.alwaysDiscardsLateVideoFrames = false
        var type = kCVPixelFormatType_420YpCbCr8BiPlanarFullRange
        if !self.videoDeviceOutput.availableVideoPixelFormatTypes.contains(type) {
            type = kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange
        }
        self.videoDeviceOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey:type] as [String : Any]
        
        let videoQueue:DispatchQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive)
        self.videoDeviceOutput.setSampleBufferDelegate(self, queue: videoQueue)
        guard self.session.canAddOutput(self.videoDeviceOutput) else {
            print("init canAddOutput failed")
            return
        }
        self.session.addOutput(self.videoDeviceOutput)
        //链接视频IO
        let connection = self.videoDeviceOutput.connection(with: .video)
        connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        if connection?.isVideoStabilizationSupported ?? false {
            connection?.preferredVideoStabilizationMode = AVCaptureVideoStabilizationMode.auto
        }
        connection?.videoScaleAndCropFactor = connection?.videoMaxScaleAndCropFactor ?? 0
        
        //音频
        guard let _audioDevice = AVCaptureDevice.default(for: .audio) else {
            print("init audioDevice failed")
            return
        }
        self.audioDevice = _audioDevice
        
        guard  let _audioDeviceInput = try? AVCaptureDeviceInput(device: self.audioDevice) else {
            print("init audioDeviceInput failed")
            return
        }
        self.audioDeviceInput = _audioDeviceInput
        self.audioDeviceOutput = AVCaptureAudioDataOutput()
        
        guard self.session.canAddOutput(self.audioDeviceOutput) else {
            print("init canAddOutput failed")
            return
        }
        self.session.addOutput(self.audioDeviceOutput)
        let audioQueue:DispatchQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive)
        self.audioDeviceOutput.setSampleBufferDelegate(self, queue: audioQueue)
        
    }
    
}

extension LeccoCaptureSession:AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate  {
    
    
    
}
