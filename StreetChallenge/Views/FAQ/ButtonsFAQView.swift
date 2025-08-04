//
//  ButtonsFAQView.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 01/06/2024.
//

import SwiftUI

struct ButtonsFAQView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "checkmark.circle")
                    Text("Question is unanswered. Tap to mark as answered")
                }
                HStack {
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(Color.buttonBackground)
                    Text("Question is marked as answered. Tap to remove")
                }
            }
            .padding()
        }
    }
}

struct ButtonsFAQView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsFAQView()
    }
}
