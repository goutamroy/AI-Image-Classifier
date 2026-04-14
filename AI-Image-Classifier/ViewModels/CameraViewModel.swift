//
//  CameraViewModel.swift
//  ImageRecognitionMealScanning
//
//  Created by Goutam Roy on 13/04/26.
//

import Vision
import CoreML
import Combine

final class CameraViewModel: ObservableObject {
    
    static let shared = CameraViewModel()
    
    @Published var prediction: String = "Detecting..."
    
    private var model: VNCoreMLModel?
    
    // ✅ NEW: Prevent frame over-processing
    private var isProcessing = false
    
    private init() {
        setupModel()
    }
    
    private func setupModel() {
        do {
            let config = MLModelConfiguration()
            config.computeUnits = .all
            
            let coreMLModel = /*try FoodClassifier(configuration: config)*/ try MobileNetV2(configuration: config)
            model = try VNCoreMLModel(for: coreMLModel.model)
            
        } catch {
            print("Model load error: \(error)")
        }
    }
    
    func processFrame(pixelBuffer: CVPixelBuffer) {
        
        // ✅ Prevent multiple frames at once
        guard !isProcessing else { return }
        isProcessing = true
        
        defer { isProcessing = false }
        
        guard let model = model else { return }
        
        let request = VNCoreMLRequest(model: model) { [weak self] request, _ in
            
            guard let results = request.results as? [VNClassificationObservation],
                  let top = results.first else { return }
            
            // ✅ Confidence threshold (avoid noisy predictions)
            guard top.confidence > 0.6 else { return }
            
            DispatchQueue.main.async {
                self?.prediction = "\(top.identifier.capitalized) (\(Int(top.confidence * 100))%)"
            }
        }
        
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer)
        
        do {
            try handler.perform([request])
        } catch {
            print("Vision error: \(error)")
        }
    }
}
