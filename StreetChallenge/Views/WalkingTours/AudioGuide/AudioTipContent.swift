//
//  AudioTipContent.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 20/06/2025.
//

import SwiftUI

struct AudioTipContent: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Premium Voice", systemImage: "speaker.wave.3")
                .font(.headline)
                .foregroundStyle(.primary)

            Text("For better audio quality, enable Premium Voice in your device settings.")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Divider()

            VStack(alignment: .leading, spacing: 6) {
                Text("Path:")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)

                Text("Settings → Accessibility → VoiceOver → Speech → Primary Voice")
                    .font(.caption).monospaced()
                    .foregroundStyle(.primary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.quaternary)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }
        }
        .padding(16)
        .frame(maxWidth: 280)
        .presentationCompactAdaptation(.popover)
    }
}
