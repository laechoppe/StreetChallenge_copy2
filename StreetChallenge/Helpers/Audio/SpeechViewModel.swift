//
//  SpeechViewModel.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 25/01/2025.
//

import SwiftUI
import AVFoundation

@MainActor
@Observable
final class SpeechViewModel: NSObject, AVSpeechSynthesizerDelegate {
    var isSpeaking = false
    var isPaused = false
    var progress: Double = 0.0
    var speechRate: Float = 0.5

    nonisolated(unsafe) private let synthesizer = AVSpeechSynthesizer()
    private var utterance: AVSpeechUtterance?
    private var words: [String] = []
    private var currentWordIndex = 0

    override init() {
        super.init()
        synthesizer.delegate = self
    }

    deinit {
        synthesizer.delegate = nil
    }

    func startSpeaking(text: String) {
        words = text.components(separatedBy: .whitespacesAndNewlines)
        currentWordIndex = 0
        progress = 0.0

        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = getVoice()
        utterance.rate = speechRate
        self.utterance = utterance

        synthesizer.speak(utterance)
        isSpeaking = true
        isPaused = false
    }

    func getVoice(language: String = "en-GB") -> AVSpeechSynthesisVoice? {
        let voices = AVSpeechSynthesisVoice.speechVoices()
        return voices.first { $0.quality == .premium && $0.language == language }
            ?? AVSpeechSynthesisVoice(language: language)
    }

    func pauseSpeaking() {
        guard synthesizer.isSpeaking, !isPaused else { return }
        synthesizer.pauseSpeaking(at: .word)
        isPaused = true
    }

    func resumeSpeaking() {
        guard isPaused else { return }
        synthesizer.continueSpeaking()
        isPaused = false
    }

    func stopSpeaking() {
        synthesizer.stopSpeaking(at: .immediate)
        isSpeaking = false
        isPaused = false
        progress = 0.0
        currentWordIndex = 0
        utterance = nil
    }

    // MARK: - AVSpeechSynthesizerDelegate

    nonisolated func speechSynthesizer(
        _ synthesizer: AVSpeechSynthesizer,
        didStart utterance: AVSpeechUtterance
    ) {
        Task { @MainActor in
            self.isSpeaking = true
        }
    }

    nonisolated func speechSynthesizer(
        _ synthesizer: AVSpeechSynthesizer,
        didFinish utterance: AVSpeechUtterance
    ) {
        Task { @MainActor in
            self.isSpeaking = false
            if self.progress == 1.0 {
                self.stopSpeaking()
            }
        }
    }

    nonisolated func speechSynthesizer(
        _ synthesizer: AVSpeechSynthesizer,
        willSpeakRangeOfSpeechString characterRange: NSRange,
        utterance: AVSpeechUtterance
    ) {
        // Extract Sendable values outside the Task closure
        let fullText = utterance.speechString
        let prefixLength = characterRange.location

        Task { @MainActor in
            // Now only Sendable types are captured
            let nsText = fullText as NSString
            let spokenSubstring = nsText.substring(with: NSRange(location: 0, length: prefixLength))
            let spokenWords = spokenSubstring
                .components(separatedBy: .whitespacesAndNewlines)
            self.currentWordIndex = spokenWords.count
            self.progress = Double(self.currentWordIndex) / Double(self.words.count)
        }
    }

}

extension SpeechViewModel: @unchecked Sendable {}
