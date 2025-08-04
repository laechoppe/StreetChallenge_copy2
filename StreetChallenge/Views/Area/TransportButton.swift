//
//  TransportButton.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 04/06/2025.
//


import SwiftUI

struct TransportButton: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundStyle(color)
                    .frame(width: 24)

                Text(title)
                    .font(.subheadline)
                    .foregroundStyle(Color.mainBlack)

                Spacer()

                Image(systemName: "arrow.up.right")
                    .font(.caption)
                    .foregroundStyle(Color.mainBlack)
            }
            .padding()
            .background(Color.mainWhite, in: RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(.plain)
    }
}
