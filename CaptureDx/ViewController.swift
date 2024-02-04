//
// ViewController.swift
//  CaptureDx
//
//  Created by Janice Liu on 2/2/24.
//

import Foundation
import AVFoundation
import UIKit


class ViewController: UIViewController {
    /*
    override func viewDidLoad() {
        super.viewDidLoad()

        if let videoURL = Bundle.main.url(forResource: "DoeJ_RUQ", withExtension: "mp4") {
            extractFrames(fromVideoAt: videoURL) { frames in
                if let frames = frames {
                    // Process or display frames as needed
                    print("Frames extracted successfully: \(frames.count)")
                } else {
                    print("Failed to extract frames.")
                }
            }
        } else {
            print("Video file not found.")
        }
    }

    func extractFrames(fromVideoAt url: URL, completion: @escaping ([UIImage]?) -> Void) {
        
        /* https://developer.apple.com/documentation/avfoundation/media_reading_and_writing/creating_images_from_a_video_asset
        */
        
        
        let asset: AVAsset = // A video asset.
        let generator = AVAssetImageGenerator(asset: asset)

        // Generate the equivalent of a 150-pixel-wide @2x image.
        generator.maximumSize = CGSize(width: 300, height: 0)
        
        // Configure the generator's time tolerance values.
        generator.requestedTimeToleranceBefore = .zero
        generator.requestedTimeToleranceAfter = CMTime(seconds: 2, preferredTimescale: 600)
        
        let times: [CMTime] = // An array of times at which to create images.
        for await result in generator.images(for: times) {
            switch result {
            case .success(requestedTime: let requested, image: let image, actualTime: let actual):
                // Process the image for the requested time.
            case .failed(requestedTime: let requested, error: let error):
                // Handle the failure for the requested time.
            }
        }
        */
        
        /*let asset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true

        var frames: [UIImage] = []
        let totalFrames = 20
        let duration = asset.duration
        let interval = CMTimeGetSeconds(duration) / Double(totalFrames)

        var currentTime = CMTime.zero

        for _ in 0..<totalFrames {
            do {
                let cgImage = try imageGenerator.copyCGImage(at: currentTime, actualTime: nil)
                let uiImage = UIImage(cgImage: cgImage)
                frames.append(uiImage)
            } catch {
                print("Error extracting frame: \(error)")
            }

            currentTime = CMTimeAdd(currentTime, CMTime(seconds: interval, preferredTimescale: currentTime.timescale))
        }

        completion(frames)
        
        
    }*/
}
