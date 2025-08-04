//
//  DescriptionSection.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 20/06/2025.
//
import SwiftUI

struct DescriptionSection: View {
    let description: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("About")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
            }

            Text(description)
                .font(.body)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.regularMaterial)
                .stroke(.quaternary, lineWidth: 0.5)
        )
    }
}
