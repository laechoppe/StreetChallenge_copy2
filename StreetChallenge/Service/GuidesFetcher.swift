//
//  GuidesFetcher.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 30/10/2024.
//

import FirebaseFirestore
import CoreLocation

protocol GuidesDataFetching: Sendable {
    func fetchPointsOfInterest() async throws -> [PointOfInterest]
}

class FirestoreGuidesService: GuidesDataFetching {
    private var db = Firestore.firestore()

    func fetchPointsOfInterest() async throws -> [PointOfInterest] {
        var fetchedPointsOfInterest: [PointOfInterest] = []
        let snapshot = try await db.collection("PointsOfInterest").getDocuments()

        for pointOfInterest in snapshot.documents {
            let data = pointOfInterest.data()

            let id = data["id"] as? String ?? ""
            let areaId = data["areaId"] as? String ?? ""
            let title = data["title"] as? String ?? ""
            let description = data["description"] as? String ?? ""
            let shortDescription = data["shortDescription"] as? String ?? ""
            let imageUrl = data["imageUrl"] as? String ?? ""
            let furtherReadingUrl = data["furtherReadingUrl"] as? String ?? ""

            var center: CLLocationCoordinate2D = .init(latitude: 0, longitude: 0)
            if let centerGeoPoint = data["center"] as? GeoPoint {
                center = CLLocationCoordinate2D(
                    latitude: centerGeoPoint.latitude,
                    longitude: centerGeoPoint.longitude
                )
            }

            let poi = PointOfInterestViewModel.createPoi(
                id: id,
                areaId: areaId,
                title: title,
                description: description.replacingOccurrences(of: "\\n", with: "\n"),
                shortDescription: shortDescription.replacingOccurrences(of: "\\n", with: "\n"),
                furtherReadingUrl: furtherReadingUrl,
                imageUrl: imageUrl,
                coordinate: center
            )
            fetchedPointsOfInterest.append(poi)

        }

        return fetchedPointsOfInterest
    }
}

extension FirestoreGuidesService: @unchecked Sendable {}
