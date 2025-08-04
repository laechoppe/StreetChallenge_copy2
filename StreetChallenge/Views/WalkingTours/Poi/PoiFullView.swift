//
//  PoiFullView.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 24/11/2024.
//

import SwiftUI
import AVFoundation
import TipKit

struct PoiFullView: View {
    @Environment(\.dismiss) var dismiss

    var poi: PointOfInterest
    var area: Area

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                HeroImageSection(url: poi.imageUrl)

                VStack(spacing: 24) {
                    AudioControlsCard(description: poi.description)

                    DescriptionSection(description: poi.description)

                    if let moreReadingUrl = poi.furtherReadingUrl {
                        FurtherReadingSection(url: moreReadingUrl)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 40)
            }
        }
        .navigationTitle(poi.title)
        .navigationBarTitleDisplayMode(.large)
        .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

// MARK: - Preview
#Preview {
    NavigationView {
        PoiFullView(poi: mockPoi4, area: mockArea)
    }
}
