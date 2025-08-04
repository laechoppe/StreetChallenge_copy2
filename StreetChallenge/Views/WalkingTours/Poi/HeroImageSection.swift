//
//  Hero.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 20/06/2025.
//

import SwiftUI

struct HeroImageSection: View {
    @Environment(ImageLoader.self) var imageLoader: ImageLoader
    @State private var imageContentMode: ContentMode = .fill

    let url: URL?

    var body: some View {
        Group {
            if let url, let image = imageLoader.images[url] {
                GeometryReader { geometry in
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: imageContentMode)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                imageContentMode = imageContentMode == .fill ? .fit : .fill
                            }
                        }
                }
                .frame(height: UIScreen.main.bounds.height * 0.4)
                .background(Color(.systemGray6))
                .overlay(
                    LinearGradient(
                        colors: [.clear, .black.opacity(0.3)],
                        startPoint: .center,
                        endPoint: .bottom
                    )
                )
            } else {
                Rectangle()
                    .fill(Color(.systemGray5))
                    .frame(height: UIScreen.main.bounds.height * 0.4)
                    .overlay(
                        ProgressView()
                            .scaleEffect(1.2)
                            .tint(.primary)
                    )
                    .shimmer()
            }
        }
        .onAppear {
            if let url {
                imageLoader.loadImage(from: url)
            }
        }
    }
    
}
