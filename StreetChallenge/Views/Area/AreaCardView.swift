//
//  AreaCardView.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 03/06/2025.
//
import SwiftUI

struct AreaCardView: View {
    @Environment(PointsOfInterestViewModel.self) private var pointsOfInterestViewModel: PointsOfInterestViewModel

    private var tourData: AreaTourDataProvider {
        AreaTourDataProvider(pointsOfInterestViewModel: pointsOfInterestViewModel, area: area)
    }

    let size: CGSize
    let area: Area
    let selectedOption: MenuOption

    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(alignment: .center, spacing: 10) {
                ZStack(alignment: .bottom) {
                    Group {
                        TileImageView(url: area.imageUrl, size: size)
                            .grayscale(area.available ? 0 : 1)
                            .overlay(
                                LinearGradient(
                                    colors: [
                                        .clear,
                                        .clear,
                                        .black.opacity(0.3),
                                        .black.opacity(0.7)
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                    }
                    .frame(width: size.width * 0.7, height: size.height * 0.7)

                    VStack(alignment: .center, spacing: 5) {
                        Text(area.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Text(tourData.subText)
                            .foregroundColor(.white.opacity(0.9))
                            .font(.callout)
                    }
                    .padding()
                }

            }
            .padding(.horizontal, 20)

            VStack(alignment: .leading) {
                if area.premium {
                    PremiumBadge()
                }
                if selectedOption == .walkingTours {
                    QuickStatItem(icon: "headphones", text: "Audio guide")
                    QuickStatItem(icon: "clock", text: tourData.tourStats.estimatedDuration)
                    QuickStatItem(icon: "location", text: tourData.tourStats.totalStops)
                }
            }
            .padding(.leading, 40)
            .padding(.top, 20)
        }
    }

    private var totalStops: [PointOfInterest] {
        pointsOfInterestViewModel.pointsOfInterest
            .filter { $0.areaId == area.id }
            .sorted { $0.id < $1.id }
    }
}

#Preview {
    AreaCardView(
        size: .init(width: 300, height: 600),
        area: mockArea,
        selectedOption: .walkingTours
    )
    .environment(ImageLoader())
}
