//
//  ImageRecognitionViewModel.swift
//  ImageRecognitionMealScanning
//
//  Created by Goutam Roy on 13/04/26.
//

import Foundation
import UIKit
import Combine
import Vision

final class ImageRecognitionViewModel: ObservableObject {
    
    @Published var results: [PredictionResult] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private let coreMLService = CoreMLService()
    
    func classify(image: UIImage) {
        errorMessage = nil
        isLoading = true
        
        coreMLService.classify(image: image) { [weak self] observations in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.isLoading = false
                
                if observations.isEmpty {
                    self.errorMessage = "No objects recognized. Try a clearer image."
                    self.results = []
                    return
                }
                
                self.results = observations
                    .map {
                        PredictionResult(identifier: $0.identifier,
                                         confidence: Double($0.confidence))
                    }
                    .sorted { $0.confidence > $1.confidence }
            }
        }
    }
}
