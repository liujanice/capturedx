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


struct ContentView: View {
    
    let model = try? miniclass_Appathon()
    //try VNCoreMLModel(for: Road_Sign_Object_Detector_1().model)
    
    @State  var currIdx: Int = 0
    @State var classificationLabel: String = ""
    
    func performClassification() {
        let photos = ["s", "a", "b"]
        
        //@State private var targetProb: Dictionary = [String:Double]()//Dictionary (String → Double)
        
        let currentImageName = photos[currIdx]
        
        guard case let img = UIImage(named: currentImageName),
              let resizedImg = img?.resizeTo(size: CGSize(width: 360, height:360)),
              let buffer = resizedImg.toBuffer() else {
            return
        }
        
        let output = try? model?.prediction(image: buffer)
        
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
        
        Button("Classify"){
            //classify image here
            
            self.performClassification()
            
        }
        Text(classificationLabel).font(.largeTitle).padding()
 
        
    }
}
    
    
    
    #Preview {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }

