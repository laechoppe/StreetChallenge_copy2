//
//  HapticFeedback.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 17/02/2025.
//
import UIKit

struct HapticManager {
    @MainActor
    static func triggerHaptic(style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
}
