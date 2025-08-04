//
//  TourStats.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 03/06/2025.
//

import Foundation

struct TourStats {
    let estimatedDuration: String
    let totalStops: String
}

class TourStatsManager {
    static func calculateStats(for stops: [PointOfInterest]) -> TourStats {
        let totalStops = stops.count

        // Estimate duration based on stops (roughly 15-20 minutes per stop)
        let estimatedMinutes = stops.count * 18
        let hours = estimatedMinutes / 60
        let minutes = estimatedMinutes % 60

        let estimatedDuration: String
        if hours > 0 {
            estimatedDuration = minutes > 0 ? "\(hours)h \(minutes)m" : "\(hours)h"
        } else {
            estimatedDuration = "\(minutes) minutes"
        }

        return TourStats(
            estimatedDuration: estimatedDuration,
            totalStops: ("\(totalStops) stops")
        )
    }
}
