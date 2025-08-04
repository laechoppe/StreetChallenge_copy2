//
//  PremiumBadge.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 03/06/2025.
//
import SwiftUI

struct PremiumBadge: View {
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "crown.fill")
                .font(.caption2)

            Text("Premium")
                .font(.caption)
                .fontWeight(.semibold)
        }
        .foregroundStyle(.orange)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            .regularMaterial,
            in: Capsule()
        )
        .background(
            .orange.opacity(0.15),
            in: Capsule()
        )
        .overlay(
            Capsule()
                .stroke(.orange.opacity(0.3), lineWidth: 0.5)
        )
    }
}

#Preview {
    PremiumBadge()
}
