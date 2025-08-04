//
//  AreaTourDataProvider.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 06/06/2025.
//


import SwiftUI

@MainActor
struct AreaTourDataProvider {
    let pointsOfInterestViewModel: PointsOfInterestViewModel

    let area: Area

    var totalStops: [PointOfInterest] {
        pointsOfInterestViewModel.pointsOfInterest
            .filter { $0.areaId == area.id }
            .sorted { $0.id < $1.id }
    }
    
    var tourStats: TourStats {
        TourStatsManager.calculateStats(for: totalStops)
    }
    
    var subText: String {
        if !area.available {
            return "Coming soon"
        } else {
            return ""
        }
    }
}
