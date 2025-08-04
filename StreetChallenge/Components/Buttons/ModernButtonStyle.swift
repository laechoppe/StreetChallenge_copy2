//
//  ModernButtonStyle.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 20/06/2025.
//

import SwiftUI

struct ModernButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}
