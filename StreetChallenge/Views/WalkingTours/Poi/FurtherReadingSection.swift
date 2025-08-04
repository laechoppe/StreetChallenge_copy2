//
//  File.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 20/06/2025.
//

import SwiftUI

struct FurtherReadingSection: View {
    let url: URL

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Link(destination: url) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Read more")
                            .font(.headline)
                            .foregroundStyle(.primary)
                    }

                    Spacer()

                    Image(systemName: "arrow.up.right")
                        .font(.title3)
                        .foregroundStyle(.tint)
                }
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.thinMaterial)
                        .stroke(.quaternary, lineWidth: 0.5)
                )
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}
