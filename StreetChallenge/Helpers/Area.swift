//
//  Area.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 28/05/2024.
//

import Foundation
import CoreLocation

struct Area: Identifiable, Hashable {
    var id: String
    var name: String
    var faq: String
    var center: CLLocationCoordinate2D
    var image: String
    var imageUrl: URL?
    var premium: Bool
    var available: Bool
    var hasGuides: Bool
    var directions: String
    var isTest: Bool

    static func == (lhs: Area, rhs: Area) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

enum MapDefaults {
    static let latitude = 51.4898
    static let longitude = -0.0882
    static let zoom = 0.5
}
