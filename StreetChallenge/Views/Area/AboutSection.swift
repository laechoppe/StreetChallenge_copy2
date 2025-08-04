//
//  AboutSection.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 04/06/2025.
//


import SwiftUI

struct AboutSection: View {
    let text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            let attrStr = try? AttributedString(
                markdown: text,
                options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace)
            )
            if let attrStr = attrStr {
                Text(attrStr)
                    .font(.body)
                    .lineSpacing(4)
                    .foregroundStyle(Color.mainBlack)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    AboutSection(text: "## Hello World")
}
