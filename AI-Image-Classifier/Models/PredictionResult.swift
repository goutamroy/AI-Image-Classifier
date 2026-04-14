//
//  PredictionResult.swift
//  ImageRecognitionMealScanning
//
//  Created by Goutam Roy on 13/04/26.
//
import Foundation

struct PredictionResult: Identifiable, Equatable {
    let id = UUID()
    let identifier: String
    let confidence: Double
    
    // ✅ Clean label for UI
    var cleanLabel: String {
        identifier
            .components(separatedBy: ",")
            .first?
            .capitalized ?? identifier
    }
}
