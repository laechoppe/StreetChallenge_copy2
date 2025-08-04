//
//  AudioControlsCard.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 20/06/2025.
//

import SwiftUI

struct AudioControlsCard: View {
    @State private var speechViewModel = SpeechViewModel()
    @State private var showAudioTip = false
    let description: String

    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 24) {
                Button(action: {
                    if speechViewModel.isPaused {
                        speechViewModel.resumeSpeaking()
                    } else if speechViewModel.isSpeaking {
                        speechViewModel.pauseSpeaking()
                    } else {
                        speechViewModel.startSpeaking(text: description)
                    }
                }) {
                    Image(systemName: speechViewModel.isSpeaking && !speechViewModel.isPaused ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 50))
                        .foregroundStyle(.tint)
                }
                .buttonStyle(ModernButtonStyle())
                .sensoryFeedback(.impact(flexibility: .soft), trigger: speechViewModel.isSpeaking)

                Button(action: {
                    speechViewModel.stopSpeaking()
                }) {
                    Image(systemName: "stop.circle.fill")
                        .font(.system(size: 50))
                        .foregroundStyle(speechViewModel.isSpeaking ? .primary : .secondary)
                }
                .buttonStyle(ModernButtonStyle())
                .disabled(!speechViewModel.isSpeaking)
                .animation(.easeInOut, value: speechViewModel.isSpeaking)
            }

            VStack(spacing: 12) {
                ProgressView(value: speechViewModel.progress)
                    .progressViewStyle(LinearProgressViewStyle(tint: .accentColor))
                    .scaleEffect(y: 2)

                HStack {
                    Spacer()
                    Button(action: {
                        showAudioTip.toggle()
                    }) {
                        Label("Audio Settings", systemImage: "info.circle")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .popover(isPresented: $showAudioTip, arrowEdge: .top) {
                        AudioTipContent()
                    }
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.regularMaterial)
                .stroke(.quaternary, lineWidth: 0.5)
        )
    }
}
