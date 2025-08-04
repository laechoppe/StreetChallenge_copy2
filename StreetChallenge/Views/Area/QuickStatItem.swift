//
//  QuickStatItem.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 03/06/2025.
//

import SwiftUI

struct QuickStatItem: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .font(.caption)
                .fontWeight(.medium)
                .frame(width: 12, height: 12)

            Text(text)
                .font(.caption)
                .fontWeight(.medium)
        }
        .foregroundStyle(.primary)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            .regularMaterial,
            in: Capsule()
        )
        .background(
            Color.black.opacity(0.1),
            in: Capsule()
        )
    }
}

#Preview {
    QuickStatItem(icon: "headphones", text: "Audio Guide")
        .background(Color.black.opacity(0.5)).clipShape(Capsule())
}
