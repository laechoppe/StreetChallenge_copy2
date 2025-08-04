//
//  AppLoadingView.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 21/06/2025.
//
import SwiftUI

struct AppLoadingView: View {
    let error: String?
    let onRetry: () -> Void

    var body: some View {
        VStack(spacing: 24) {

            Text("Street Challenge")
                .font(.largeTitle)
                .fontWeight(.bold)

            if let error = error {
                // Error state
                VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 48))
                        .foregroundColor(.orange)

                    Text("Initialization Failed")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text(error)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)

                    Button("Retry") {
                        onRetry()
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                }
            } else {
                // Loading state
                VStack(spacing: 16) {
                    ProgressView()
                        .scaleEffect(1.5)
                        .padding()

                    Text("Loading...")
                        .font(.headline)
                        .foregroundColor(.secondary)

                    Text("Setting up your experience")
                        .font(.subheadline)
                        .foregroundColor(.tertiary)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

#Preview {
    AppLoadingView(error: nil, onRetry: {})
}
