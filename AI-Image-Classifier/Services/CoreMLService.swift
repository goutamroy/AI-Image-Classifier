//
//  CoreMLService.swift
//  ImageRecognitionMealScanning
//
//  Created by Goutam Roy on 13/04/26.
//

//import CoreML
//import Vision
//import UIKit
//
//final class CoreMLService {
//    
//    private let model: VNCoreMLModel
//    
//    init() {
//        do {
//            let config = MLModelConfiguration()
//            let coreMLModel = try FoodClassifier(configuration: config).model
//            self.model = try VNCoreMLModel(for: coreMLModel)
//        } catch {
//            fatalError("❌ Failed to load CoreML model: \(error)")
//        }
//    }
//    
//    func classify(image: UIImage, completion: @escaping ([VNClassificationObservation]) -> Void) {
//        
//        guard let ciImage = CIImage(image: image) else {
//            completion([])
//            return
//        }
//        
//        let request = VNCoreMLRequest(model: model) { request, error in
//            
//            if let error = error {
//                print("❌ Vision Error:", error.localizedDescription)
//                completion([])
//                return
//            }
//            
//            let results = request.results as? [VNClassificationObservation] ?? []
//            completion(results)
//        }
//        
//        request.imageCropAndScaleOption = .centerCrop
//        
//        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
//        
//        DispatchQueue.global(qos: .userInitiated).async {
//            do {
//                try handler.perform([request])
//            } catch {
//                print("❌ CoreML Error:", error.localizedDescription)
//                completion([])
//            }
//        }
//    }
//}

import CoreML
import Vision
import UIKit

final class CoreMLService {
    
    private let model: VNCoreMLModel
    
    init() {
        do {
            let config = MLModelConfiguration()
            let coreMLModel = try MobileNetV2(configuration: config).model
            self.model = try VNCoreMLModel(for: coreMLModel)
        } catch {
            fatalError("Model load failed: \(error)")
        }
    }
    
    func classify(image: UIImage, completion: @escaping ([VNClassificationObservation]) -> Void) {
        
        guard let ciImage = CIImage(image: image) else {
            completion([])
            return
        }
        
        let request = VNCoreMLRequest(model: model) { request, _ in
            let results = request.results as? [VNClassificationObservation] ?? []
            completion(results.prefix(3).map { $0 })
        }
        
        let handler = VNImageRequestHandler(ciImage: ciImage)
        
        DispatchQueue.global(qos: .userInitiated).async {
            try? handler.perform([request])
        }
    }
}
