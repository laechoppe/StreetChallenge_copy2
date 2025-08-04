//
//  ShimmerModifier.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 20/06/2025.
//

import SwiftUI

extension View {
    func shimmer() -> some View {
        modifier(ShimmerModifier())
    }
}

struct ShimmerModifier: ViewModifier {
    @State private var phase: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .overlay(
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [.clear, .white.opacity(0.3), .clear],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .scaleEffect(x: 3, y: 1)
                    .offset(x: phase)
                    .animation(
                        Animation.linear(duration: 1.5).repeatForever(autoreverses: false),
                        value: phase
                    )
            )
            .onAppear {
                phase = 300
            }
    }
}
