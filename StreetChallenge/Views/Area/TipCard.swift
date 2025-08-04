//
//  TipCard.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 06/06/2025.
//

import SwiftUI

struct TipCard: View {
    let icon: String
    let title: String
    let description: String
    let color: Color

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(color)
                .frame(width: 24)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.mainBlack)

                Text(description)
                    .font(.caption)
                    .foregroundStyle(Color.gray)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer(minLength: 0)
        }
        .padding()
        .background(color.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    TipCard(icon: "person.fill", title: "Feature", description: "Description", color: .blue)
}
