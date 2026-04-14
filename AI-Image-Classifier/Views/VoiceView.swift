//
//  VoiceView.swift
//  ImageRecognitionMealScanning
//
//  Created by Goutam Roy on 13/04/26.
//
import SwiftUI

struct VoiceView: View {
    
    @StateObject private var viewModel = VoiceViewModel()
    
    var body: some View {
        VStack(spacing: 30) {
            
            Text("Voice Assistant")
                .font(.largeTitle)
                .bold()
            
            Text(viewModel.recognizedText)
                .padding()
                .foregroundColor(.gray)
            
            Button(viewModel.isListening ? "Stop Listening" : "Start Listening") {
                viewModel.toggleListening()
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .padding()
    }
}
