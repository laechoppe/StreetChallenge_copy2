//
//  PointOfInterestViewModel.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 30/10/2024.
//

import Foundation
import CoreLocation
import FirebaseFirestore

class PointOfInterestViewModel {

    static func createPoi(
        id: String,
        areaId: String,
        title: String,
        description: String,
        shortDescription: String,
        furtherReadingUrl: String,
        imageUrl: String,
        coordinate: CLLocationCoordinate2D?
    ) -> PointOfInterest {

        return PointOfInterest(
            id: id,
            areaId: areaId,
            title: title,
            description: description,
            shortDescription: shortDescription,
            furtherReadingUrl: URL(string: furtherReadingUrl),
            imageUrl: URL(string: imageUrl),
            coordinate: coordinate
        )

    }
}
