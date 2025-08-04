//
//  PointOfInterest.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 30/10/2024.
//

import Foundation
import CoreLocation

struct PointOfInterest: Identifiable, Hashable {
    static func == (lhs: PointOfInterest, rhs: PointOfInterest) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    var id: String
    var areaId: String
    var title: String
    var description: String
    var shortDescription: String
    var furtherReadingUrl: URL?
    var imageUrl: URL?
    var coordinate: CLLocationCoordinate2D?
}
