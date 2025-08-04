//
//  OnboardingFooter.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 03/06/2025.
//

import SwiftUI

struct Footer: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("By continuing, you agree to our")
                .foregroundColor(.white.opacity(0.7))

            HStack(spacing: 6) {
                Link(destination: URL(string: "https://www.streetchallenge.uk/street-challenge/terms")!) {
                    Text("Terms & Conditions")
                        .fontWeight(.medium)
                        .foregroundColor(.white.opacity(0.9))
                }

                Text("and")
                    .foregroundColor(.white.opacity(0.7))

                Link(destination: URL(string: "https://www.streetchallenge.uk/street-challenge/privacy-policy")!) {
                    Text("Privacy Policy")
                        .fontWeight(.medium)
                        .foregroundColor(.white.opacity(0.9))
                }
            }
        }
        .font(.caption)
        .multilineTextAlignment(.center)
    }
}

#Preview {
    Footer()
        .background(Color.black)
}
