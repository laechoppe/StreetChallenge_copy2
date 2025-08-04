//
//  AreaGuideHeaderView.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 06/06/2025.
//


import SwiftUI

struct AreaGuideHeaderView: View {
    let area: Area
    @Environment(ImageLoader.self) private var imageLoader: ImageLoader
    @Environment(PointsOfInterestViewModel.self) private var pointsOfInterestViewModel: PointsOfInterestViewModel

    private let headerHeight: CGFloat = UIScreen.main.bounds.height * 0.4

    private var tourData: AreaTourDataProvider {
        AreaTourDataProvider(
            pointsOfInterestViewModel: pointsOfInterestViewModel, area: area
        )
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            GeometryReader { geometry in
                let minY = geometry.frame(in: .global).minY
                let height = geometry.size.height

                ZStack {
                    if let url = area.imageUrl, let image = imageLoader.images[url] {
                        ResizableImageView(image: image)
                            .frame(
                                width: geometry.size.width,
                                height: minY > 0 ? height + minY : height
                            )
                            .clipped()
                            .offset(y: minY > 0 ? -minY : 0)
                    } else {
                        ProgressView()
                            .frame(height: height)
                    }
                }
            }
            .frame(height: headerHeight)

            LinearGradient(
                colors: [
                    .clear,
                    .clear,
                    .black.opacity(0.3),
                    .black.opacity(0.7)
                ],
                startPoint: .top,
                endPoint: .bottom
            ).frame(height: headerHeight)


            VStack(alignment: .leading, spacing: 12) {
                if area.premium {
                    PremiumBadge()
                }

                Text(area.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)

                HStack(spacing: 20) {
                    QuickStatItem(icon: "headphones", text: "Audio guide")
                    QuickStatItem(icon: "clock", text: tourData.tourStats.estimatedDuration)
                    QuickStatItem(icon: "location", text: tourData.tourStats.totalStops)
                }
            }
            .padding()
        }
    }
}


#Preview {
    AreaGuideHeaderView(area: mockArea)
        .environment(ImageLoader())
}

