//
//  ContentView.swift
//  CaptureDx
//
//  Created by Janice Liu on 2/2/24.
//

import SwiftUI
import Vision
import ImageIO
import CoreML
import CoreData
import Foundation
import AVFoundation
import CoreFoundation


struct ContentView: View {
    
    
   /*
    let movieURL = Bundle.module.url(forResource: "Example", withExtension: "mov")!
    let model = try! await miniclass_Appathon(configuration: MLModelConfiguration())

    let asset = AVAsset(url: movieURL)
    let assetTrack = try! await asset.loadTracks(withMediaType: .video).first!
    let assetReader = try! AVAssetReader(asset: asset)

    let outputSettings: [String: Any] = [
        String(kCVPixelBufferPixelFormatTypeKey): kCVPixelFormatType_32BGRA,
        String(kCVPixelBufferWidthKey): 224,
        String(kCVPixelBufferHeightKey): 224,/// I believe these are meant to be 360px
    ]
    let assetReaderTrack = AVAssetReaderTrackOutput(track: assetTrack, outputSettings: outputSettings)

    func assetReader;.add(assetReaderTrack)
    assetReader.startReading()

    while; let sampleBuffer = assetReaderTrack.copyNextSampleBuffer() {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            continue
        }

     //   let prediction = try! model.prediction(image: pixelBuffer) /// Modify this to be a VnCoreML request https://developer.apple.com/documentation/vision/vncoremlrequest
        let frameTime = String(format: "% 4.2f", CMSampleBufferGetPresentationTimeStamp(sampleBuffer).seconds)
        print("\(frameTime) seconds: \(prediction.classLabel)")
    }
        
       */
        
    @State var currIdx: Int = 0
    @State var classificationLabel: String = ""
    
    let photos = ["framePUL_0", "framePUL_1", "framePUL_2", "frameCAR_0", "frameCAR_1",  "frameCAR_2"]
    let model = try! miniclass_Appathon()
    //try VNCoreMLModel(for: Road_Sign_Object_Detector_1().model)
    
    
    
    //convert png to UIimage
    
    //copy the images into the app bundle, if you require the folder to be copied to the app bundle per the code below then please use the follow StackOverflow question to set it up correctly.
    
    //This gives us an array of URL's that we can then use with UIImage(data:) and NSData(contentsOfURL:) to create the image when needed.
    
    //Get the bundle's resource path and append the image directory then get the contents of the directory.
    
    /*
     NSBundle *main = [NSBundle mainBundle];
     
     if let path = NSBundle.mainBundle().resourcePath {
     
     let imagePath = path + "/images"
     let url = NSURL(fileURLWithPath: imagePath)
     let fileManager = NSFileManager.defaultManager()
     
     let properties = [NSURLLocalizedNameKey,
     NSURLCreationDateKey, NSURLLocalizedTypeDescriptionKey]
     
     do {
     let imageURLs = try fileManager.contentsOfDirectoryAtURL(url, includingPropertiesForKeys: properties, options:NSDirectoryEnumerationOptions.SkipsHiddenFiles)
     
     print("image URLs: \(imageURLs)")
     // Create image from URL
     var myImage =  UIImage(data: NSData(contentsOfURL: imageURLs[0])!)
     
     } catch let error1 as NSError {
     print(error1.description)
     }
     }
     
     
     
     public func convert(image: Image, callback: @escaping ((UIImage?) -> Void)) {
     DispatchQueue.main.async {
     let renderer = ImageRenderer(content: image)
     
     // to adjust the size, you can use this (or set a frame to get precise output size)
     // renderer.scale = 0.25
     
     // for CGImage use renderer.cgImage
     callback(renderer.uiImage)
     }
     }
     
     */
    
    
    
    func performClassification() {
        //load photos from each folder
        
        //for p in folder:
        //            convert(image: <#T##Image#>, callback: <#T##((UIImage?) -> Void)##((UIImage?) -> Void)##(UIImage?) -> Void#>)
        
        
        
        
        //@State private var targetProb: Dictionary = [String:Double]()//Dictionary (String → Double)
        print("entered function")
        let currentImageName = photos[currIdx]
        
        guard case let img = UIImage(named: currentImageName),
              let resizedImg = img?.resizeTo(size: CGSize(width: 360, height:360)),
              let buffer = resizedImg.toBuffer() else {
            return
        }
        /*
        print(img ?? 0)
        print ("\n")
        print(resizedImg )
        print ("\n")
        print(buffer )
         //not empty
        */
        
        let output = try? model.prediction(image: buffer) //calling model not working

 
        print(output ?? 0)
        if let output = output {
            // self.classificationLabel = output.target
            
            //self.targetProb = output.targetProbability
            
            let results = output.targetProbability.sorted{$0.1 > $1.1}
            
            let result = results.map{(key, value) in
                return "\(key) = \(value * 100)%"
            }.joined(separator: "\n")
            
            classificationLabel = result
            
        }
        
        
    }
    
    
    //
    
    
    var body: some View {
        
        
        VStack {
            
            Image (
                photos[currIdx]).resizable().frame(width: 360, height: 360)
            
            HStack {
                
                Button("Previous") {
                    
                    if self.currIdx >= self.photos.count
                    { self.currIdx = self.currIdx - 1}
                    else {
                        self.currIdx = 0}
                }.padding().foregroundColor(Color.white).background (Color.gray).cornerRadius (10).frame(width: 100)
                
                Button("Next") {
                    if self.currIdx < self.photos.count - 1 {
                        self.currIdx = self.currIdx + 1
                    } else {
                        self.currIdx = 0}}.padding().foregroundColor(Color.white).frame(width: 100).background(Color.gray).cornerRadius (10)}.padding()
            
            
            Button("Scan"){
                //upload, scan, classify image here
                
                self.performClassification()
                
            }.padding()
            
            Text(classificationLabel).font(.largeTitle).padding()
            
            
        }
    }
}
    
    
    
    #Preview {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
    
