//
//  SpeechService.swift
//  ImageRecognitionMealScanning
//
//  Created by Goutam Roy on 13/04/26.
//

import Foundation
import Speech
import AVFoundation


final class SpeechService {
    
    private let recognizer = SFSpeechRecognizer()
    private let audioEngine = AVAudioEngine()
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?
    
    func startListening(completion: @escaping (String) -> Void) {
        
        SFSpeechRecognizer.requestAuthorization { status in
            guard status == .authorized else { return }
            
            DispatchQueue.main.async {
                self.startSession(completion: completion)
            }
        }
    }
    
    private func startSession(completion: @escaping (String) -> Void) {
        
        stopListening()
        
        request = SFSpeechAudioBufferRecognitionRequest()
        guard let request = request else { return }
        
        let inputNode = audioEngine.inputNode
        
        // 🔴 Remove previous tap
        inputNode.removeTap(onBus: 0)
        
        task = recognizer?.recognitionTask(with: request) { result, error in
            
            if let result = result {
                completion(result.bestTranscription.formattedString)
            }
            
            if error != nil {
                self.stopListening()
            }
        }
        
        // ✅ FIX: Use inputFormat instead of outputFormat
        let format = inputNode.inputFormat(forBus: 0)
        
        guard inputNode.inputFormat(forBus: 0).channelCount > 0 else {
            print("Invalid audio format")
            return
        }
        
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: format) {
            buffer, _ in
            request.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("Audio Engine failed: \(error)")
        }
    }
    
    func stopListening() {
        
        if audioEngine.isRunning {
            audioEngine.stop()
        }
        
        request?.endAudio()
        task?.cancel()
        task = nil
        
        // 🔴 CRITICAL: Remove tap safely
        audioEngine.inputNode.removeTap(onBus: 0)
    }
}
