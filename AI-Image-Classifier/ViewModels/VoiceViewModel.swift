//
//  VoiceViewModel.swift
//  ImageRecognitionMealScanning
//
//  Created by Goutam Roy on 13/04/26.
//

import Foundation
import Speech
import Combine

final class VoiceViewModel: ObservableObject {
    
    @Published var recognizedText: String = "Start Listening"
    @Published var isListening = false
    
    private let speechService = SpeechService()
    
    func toggleListening() {
        guard !isListening else {
            speechService.stopListening()
            isListening = false
            return
        }
        startListening()
    }
    
    private func startListening() {
        isListening = true
        
        speechService.startListening { [weak self] text in
            DispatchQueue.main.async {
                self?.recognizedText = text
            }
        }
    }
}
