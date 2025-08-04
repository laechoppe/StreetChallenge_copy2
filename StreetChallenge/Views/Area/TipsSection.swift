//
//  TipsSection.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 06/06/2025.
//

import SwiftUI

struct TipsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            TipCard(
                icon: "headphones",
                title: "Audio Experience",
                description: "Best experienced with headphones. The tour works offline once downloaded.",
                color: Color.blue
            )

            TipCard(
                icon: "figure.walk",
                title: "Walking Pace",
                description: "Take your time at each stop. The tour is self-paced and you can pause anytime.",
                color: Color.blue
            )

            TipCard(
                icon: "camera",
                title: "Photo Opportunities",
                description: "Don't forget your camera! Each stop has unique photo opportunities.",
                color: Color.blue
            )

            TipCard(
                icon: "battery.100",
                title: "Device Preparation",
                description: "Ensure your device is charged. Tours typically last 2-3 hours.",
                color: Color.blue
            )
        }
    }
}

#Preview {
    TipsSection()
}
