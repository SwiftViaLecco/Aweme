//
//  LeccoVideoMerge.swift
//  Aweme
//
//  Created by lecco on 2018/11/19.
//  Copyright © 2018 lecco. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

extension AVAsset {
    var g_size: CGSize {
        return tracks(withMediaType: AVMediaType.video).first?.naturalSize ?? .zero
    }
    var g_orientation: UIInterfaceOrientation {
        guard let transform = tracks(withMediaType: AVMediaType.video).first?.preferredTransform else {
            return .portrait
        }
        switch (transform.tx,transform.ty) {
        case (0,0):
            return .landscapeRight
        case (g_size.width, g_size.height):
            return .landscapeLeft
        case (0, g_size.width):
            return .portraitUpsideDown
        default:
            return .portrait
        }
    }
}

class LeccoVideoMerge: NSObject {
    
    var videoAsset: AVAsset?
    var videoAssetURL: URL?
    var avAssetArray = [AVAsset]()
    
    
    let VIDEO_HEIGHT = kScreenHeight
    let VIDEO_WIDTH = kScreenWitdh
    
    func mergeVideo(_ assetsArray:[URL]) {
        var assets:[AVAsset] = []
        for url in assetsArray {
            assets.append(AVAsset(url: url))
        }
        self.mergeVideo(assets)
    }
    
    class func leccoJoinVideos(urls:[URL]?,handler: @escaping (_ joinedUrl:URL?) -> Void) -> Void {
        self.compostionToAsset(comp: self.combVideos(urls: urls), handler: handler)
    }
    
    class func compostionToAsset(comp:AVMutableComposition?,handler: @escaping (_ url:URL?) -> Void) ->Void {
        guard (comp != nil) else {
            handler(nil)
            return
        }
        let url = URL(fileURLWithPath: NSString.path(withComponents: [NSTemporaryDirectory(), "MixAwemeAppVideo.MOV"]))
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
        }
        
        //transforms
        
        guard let assetExporter = AVAssetExportSession(asset: comp!,presetName: AVAssetExportPresetHighestQuality) else {
            handler(nil)
            return
        }
        assetExporter.outputURL = url as URL
        assetExporter.outputFileType = AVFileType.mov
        assetExporter.shouldOptimizeForNetworkUse = true
        
        //do the export
        assetExporter.exportAsynchronously {
            switch assetExporter.status {
            case .unknown:
                print("unknown")
            case .waiting:
                print("waiting")
            case .exporting:
                print("exporting")
            case .completed:
                handler(url)
            case .failed:
                print(assetExporter.error?.localizedDescription ?? "")
                handler(nil)
            case .cancelled:
                 handler(nil)
            }
            
        }
    }
    
    class func combVideos(urls:[URL]?) -> AVMutableComposition? {
        if urls == nil || urls?.count == 0 {
            return nil
        }
        let composition = AVMutableComposition()
        let videoTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
        let audioTrack = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)
//        var videoTrackArray:[AVAssetTrack] = []
//        var audioTrackArray:[AVAssetTrack] = []
//        var timeArray:[NSValue] = []
        for (_,url) in urls!.enumerated() {
            let asset = AVAsset(url: url)
            let timeRange = CMTimeRange(start: CMTime.zero, end: asset.duration)
//            timeArray.append(NSValue(timeRange: timeRange))
            let video = asset.tracks(withMediaType: .video).first!
            let audio = asset.tracks(withMediaType: .audio).first!
//            videoTrackArray.append(asset.tracks(withMediaType: .video).first!)
//            audioTrackArray.append(asset.tracks(withMediaType: .audio).first!)
            do {
                videoTrack?.preferredTransform = video.preferredTransform
                try videoTrack?.insertTimeRange(timeRange, of: video, at: CMTime.invalid)
                try audioTrack?.insertTimeRange(timeRange, of: audio, at: CMTime.invalid)
            } catch {
                print("\(error)")
            }
        }
        //视频旋转
//        let tranoform = videoTrack?.preferredTransform
//        let rotation = CGAffineTransform(rotationAngle: 2 * .pi)
//        videoTrack?.preferredTransform = rotation
        return composition
    }
    
    func mergeVideo(_ assetsArray:[AVAsset]){
        
        let mainComposition = AVMutableVideoComposition()
        let mixComposition = AVMutableComposition()
        let mainInstruction = AVMutableVideoCompositionInstruction()
        var allVideoInstruction = [AVMutableVideoCompositionLayerInstruction]()
        var startDuration: CMTime = CMTime.zero
        for i in 0..<assetsArray.count {
            let currentAsset:AVAsset = assetsArray[i]
            guard let currentTrack = mixComposition.addMutableTrack(withMediaType: AVMediaType.video,
                                                                    preferredTrackID: Int32(kCMPersistentTrackID_Invalid))
                else {   return  }
            
            do {
                try currentTrack.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: currentAsset.duration),
                                                 of: currentAsset.tracks(withMediaType: AVMediaType.video)[0],
                                                 at: startDuration)
                let currentInstruction = videoCompositionInstructionForTrack(track: currentTrack, asset: currentAsset)
                
                
                currentInstruction.setOpacityRamp(fromStartOpacity: 0.0, toEndOpacity: 1.0,
                                                  timeRange: CMTimeRangeMake(start: startDuration, duration: CMTimeMake(value: 1, timescale: 1)))
                
                if i != assetsArray.count - 1 {
                    
                    currentInstruction.setOpacityRamp(fromStartOpacity: 1.0,
                                                      toEndOpacity: 0.0,
                                                      timeRange: CMTimeRangeMake(start: CMTimeSubtract(CMTimeAdd(currentAsset.duration, startDuration),CMTimeMake(value: 1,timescale: 1)), duration: CMTimeMake(value: 2,timescale: 1)))
                }
                let transform = currentTrack.preferredTransform
                
                if orientationFromTransform(transform: transform).isPortrait {
                    let outputSize = CGSize(width: VIDEO_WIDTH, height: VIDEO_HEIGHT)
                    let horizontalRatio = CGFloat(outputSize.width) / currentTrack.naturalSize.width
                    
                    let verticalRatio = CGFloat(outputSize.height) / currentTrack.naturalSize.height
                    let scaleToFitRatio = max(horizontalRatio,verticalRatio)
                    let FirstAssetScaleFactor = CGAffineTransform(scaleX: scaleToFitRatio, y: scaleToFitRatio)
                    
                    if currentAsset.g_orientation == .landscapeLeft {
                        print("is landscape")
                        let rotation = CGAffineTransform(rotationAngle: .pi)
                        
                        let translateToCenter = CGAffineTransform(translationX: CGFloat(VIDEO_WIDTH), y: CGFloat(VIDEO_HEIGHT))
                        let mixedTransform = rotation.concatenating(translateToCenter)
                        currentInstruction.setTransform(currentTrack.preferredTransform.concatenating(FirstAssetScaleFactor).concatenating(mixedTransform), at: CMTime.zero)
                        
                    } else {
                        currentInstruction.setTransform(currentTrack.preferredTransform.concatenating(FirstAssetScaleFactor), at: CMTime.zero)
                    }
                }
                allVideoInstruction.append(currentInstruction)
                startDuration = CMTimeAdd(startDuration,currentAsset.duration)
                
            }
            catch {  }
            
        }
        mainInstruction.timeRange = CMTimeRangeMake(start: CMTime.zero,duration: startDuration)
        mainInstruction.layerInstructions = allVideoInstruction
        
        mainComposition.instructions = [mainInstruction]
        mainComposition.frameDuration = CMTimeMake(value: 1, timescale: 30)
        //mainComposition.renderSize = CGSize(width: 300.0, height: 300.0)
        mainComposition.renderSize = CGSize(width: VIDEO_WIDTH, height: VIDEO_HEIGHT)
        
        //mainComposition.renderSize = CGSize(width: VIDEO_WIDTH, height: VIDEO_HEIGHT)
        
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        let date = dateFormatter.string(from: Date())
        
        let savePath = (documentDirectory as NSString).appendingPathComponent("mergeVideo-\(date).mp4")
        
        let url = NSURL(fileURLWithPath: savePath)
        
        guard let assetExporter = AVAssetExportSession(asset: mixComposition,presetName: AVAssetExportPresetHighestQuality) else { return }
        
        assetExporter.outputURL = url as URL
        assetExporter.outputFileType = AVFileType.mov
        assetExporter.shouldOptimizeForNetworkUse = true
        assetExporter.videoComposition = mainComposition
        
        //do the export
        assetExporter.exportAsynchronously {
            DispatchQueue.main.async {
                print("exporting")
                self.exportDidFinish(session: assetExporter)
            }
        }
    }
    
    
    func videoCompositionInstructionForTrack(track: AVCompositionTrack, asset: AVAsset) -> AVMutableVideoCompositionLayerInstruction {
        let instruction = AVMutableVideoCompositionLayerInstruction(assetTrack: track)
        
        let assetTrack = asset.tracks(withMediaType: AVMediaType.video)[0]
        let transform = assetTrack.preferredTransform
        let assetInfo = orientationFromTransform(transform: transform)
        var scaleToFitRatio = UIScreen.main.bounds.width / assetTrack.naturalSize.width
        
        if assetInfo.isPortrait {
            scaleToFitRatio = UIScreen.main.bounds.width / assetTrack.naturalSize.height
            let scaleFactor = CGAffineTransform(scaleX: scaleToFitRatio, y: scaleToFitRatio)
            
            instruction.setTransform(assetTrack.preferredTransform.concatenating(scaleFactor), at: CMTime.zero)
            
        } else {
            
            let scaleFactor = CGAffineTransform(scaleX: scaleToFitRatio, y: scaleToFitRatio)
            
            var concat = assetTrack.preferredTransform.concatenating(scaleFactor).concatenating(CGAffineTransform(translationX:0, y:UIScreen.main.bounds.width / 2))
            
            if assetInfo.orientation == .down {
                let fixUpsideDown = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
                
                let windowsBounds = UIScreen.main.bounds
                let yFix = assetTrack.naturalSize.height + windowsBounds.height
                let centerFix = CGAffineTransform(translationX: assetTrack.naturalSize.width, y: yFix)
                
                concat = fixUpsideDown.concatenating(centerFix).concatenating(scaleFactor)
            }
            instruction.setTransform(concat, at: CMTime.zero)
            
        }
        return instruction
        
        
    }
    
    
    func orientationFromTransform(transform: CGAffineTransform) -> (orientation: UIImage.Orientation, isPortrait: Bool){
        var assetOrientation = UIImage.Orientation.up
        var isPortrait = false
        if transform.a == 0 && transform.b == 1.0 && transform.c == -1.0 && transform.d == 0 {
            assetOrientation = .right
            
            isPortrait = true
        } else if transform.a == 0 && transform.b == -1.0 && transform.c == 1.0 && transform.d == 0 {
            assetOrientation = .left
            
            isPortrait = true
        } else if transform.a == 1.0 && transform.b == 0 && transform.c == 0 && transform.d == 1.0 {
            assetOrientation = .up
            
        } else if transform.a == -1.0 && transform.b == 0 && transform.c == 0 && transform.d == -1.0 {
            assetOrientation = .down
        }
        return (assetOrientation, isPortrait)
    }
    
    class func orientationFromTransform(transform: CGAffineTransform) -> (orientation: UIImage.Orientation, isPortrait: Bool){
        var assetOrientation = UIImage.Orientation.up
        var isPortrait = false
        if transform.a == 0 && transform.b == 1.0 && transform.c == -1.0 && transform.d == 0 {
            assetOrientation = .right
            
            isPortrait = true
        } else if transform.a == 0 && transform.b == -1.0 && transform.c == 1.0 && transform.d == 0 {
            assetOrientation = .left
            
            isPortrait = true
        } else if transform.a == 1.0 && transform.b == 0 && transform.c == 0 && transform.d == 1.0 {
            assetOrientation = .up
            
        } else if transform.a == -1.0 && transform.b == 0 && transform.c == 0 && transform.d == -1.0 {
            assetOrientation = .down
        }
        return (assetOrientation, isPortrait)
    }
    
    
    func exportDidFinish(session: AVAssetExportSession) {
        print("running exportDidFinish")
        if session.status == AVAssetExportSession.Status.completed {
            guard let outputURL = session.outputURL else {
                print("could not set outputURL")
                return
            }
            
            videoAssetURL = outputURL
            //MARK: let library = ALAssetsLibrary()
            PHPhotoLibrary.shared().performChanges({
                let options = PHAssetResourceCreationOptions()
                options.shouldMoveFile = false
                
                //MARK: Create video file
                
                let creationRequest = PHAssetCreationRequest.forAsset()
                creationRequest.addResource(with: .video, fileURL:  outputURL, options: options)
                print("save to PhotoLib")
            }, completionHandler: { (success, error) in
                if !success {
                    print("Could not save video to photo library: ",error?.localizedDescription ?? "error code not found: SaveToPhotoLibrary")
                    return
                }
                print("Ⓜ️save video to PhotosAlbum")
                self.avAssetArray.removeAll()
                
            }
            )}
    }
}
