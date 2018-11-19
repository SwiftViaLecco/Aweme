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
    var videoConnection:AVCaptureConnection!
    var audioConnection:AVCaptureConnection!
    
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
    
    
    
    private var _captureDevicePosition:AVCaptureDevice.Position = .back
    var captureDevicePosition:AVCaptureDevice.Position {
        get {
            return _captureDevicePosition
        }
        set {
            self.changeDevicePropertySafety { (captureDevice) in
                _captureDevicePosition = newValue
                self.videoDevice = self.device(mediaType: AVMediaType.video, preferringPostion: _captureDevicePosition)
                guard let newVideoInput = try? AVCaptureDeviceInput(device: videoDevice) else {
                    print("change property failed:AVCaptureDeviceInput")
                    return
                }
                self.session.removeInput(self.videoDeviceInput)
                guard self.session.canAddInput(newVideoInput) else {
                    print("init canAddOutput failed")
                    self.session .removeInput(self.videoDeviceInput)
                    return
                }
                self.videoDeviceInput = newVideoInput
                self.session.addInput(self.videoDeviceInput)
            }
            
        }
    }
    
    
    //获取所需要的设备对象
    private func device(mediaType:AVMediaType, preferringPostion:AVCaptureDevice.Position) -> AVCaptureDevice! {
        let devices = AVCaptureDevice.devices(for: mediaType)
        var captureDevice = devices.first
        for device in devices {
            if device.position == preferringPostion {
                captureDevice = device
                break
            }
        }
        return captureDevice
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
        self.videoConnection = self.videoDeviceOutput.connection(with: .video)
        self.videoConnection?.videoOrientation = AVCaptureVideoOrientation.portrait
        if self.videoConnection?.isVideoStabilizationSupported ?? false {
            self.videoConnection?.preferredVideoStabilizationMode = AVCaptureVideoStabilizationMode.auto
        }
        self.videoConnection?.videoScaleAndCropFactor = self.videoConnection?.videoMaxScaleAndCropFactor ?? 0
        
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
        self.audioConnection = self.audioDeviceOutput.connection(with: .audio)
        let audioQueue:DispatchQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive)
        self.audioDeviceOutput.setSampleBufferDelegate(self, queue: audioQueue)
        
    }
    
    func changeDevicePropertySafety(safetyBlock:(_ captionDevice:AVCaptureDevice) -> Void) -> Void {
        let captionDevice = self.videoDeviceInput.device
        guard let _ = try? captionDevice.lockForConfiguration() else {
            print("call lockForConfiguration failed")
            return
        }
        self.session.beginConfiguration()
        safetyBlock(captionDevice)
        captionDevice .unlockForConfiguration()
        self.session .commitConfiguration()
    }
    
}

extension LeccoCaptureSession:AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate  {
    
  
    
    //MARK: AVCaptureVideoDataOutputSampleBufferDelegate & AVCaptureAudioDataOutputSampleBufferDelegate
    func captureOutput(_ output: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        //only for video
        
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        //video and audio
        let formatDescription = CMSampleBufferGetFormatDescription(sampleBuffer)
        if connection == self.videoConnection {
        } else if connection == self.audioConnection {
        }
        
    }
    
    
    
    
    
    
    
    
}
