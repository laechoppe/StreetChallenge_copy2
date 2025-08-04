//
//  AreasDataService.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 29/09/2024.
//

import FirebaseFirestore
import CoreLocation

protocol AreasDataFetching: Sendable {
    func fetchAreas() async throws -> [Area]
}

class FirestoreAreasService: AreasDataFetching {
    private var db = Firestore.firestore()

    func fetchAreas() async throws -> [Area] {

        let snapshot = try await db.collection("Areas").getDocuments()

        var fetchedAreas: [Area] = []

        for document in snapshot.documents {
            if let area = parseArea(from: document) {
                fetchedAreas.append(area)
            }
        }

        return fetchedAreas
    }

    private func parseArea(from document: QueryDocumentSnapshot) -> Area? {
        let data = document.data()

        // Required fields
        guard let name = data["name"] as? String, !name.isEmpty else {
            return nil
        }

        let id = data["id"] as? String ?? document.documentID

        // Optional fields with safe defaults
        let faq = (data["faq"] as? String ?? "").replacingOccurrences(of: "\\n", with: "\n")
        let image = data["image"] as? String ?? ""
        let imageUrlString = data["imageUrl"] as? String ?? ""
        let premium = data["premium"] as? Bool ?? false
        let available = data["available"] as? Bool ?? false
        let hasGuides = data["hasGuides"] as? Bool ?? false
        let directions = (data["directions"] as? String ?? "").replacingOccurrences(of: "\\n", with: "\n")
        let isTest = data["isTest"] as? Bool ?? true

        // Parse location safely
        var center = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        if let centerGeoPoint = data["center"] as? GeoPoint {
            center = CLLocationCoordinate2D(
                latitude: centerGeoPoint.latitude,
                longitude: centerGeoPoint.longitude
            )
        }

        let area = Area(
            id: id,
            name: name,
            faq: faq,
            center: center,
            image: image,
            imageUrl: URL(string: imageUrlString),
            premium: premium,
            available: available,
            hasGuides: hasGuides,
            directions: directions,
            isTest: isTest
        )

        return area
    }
}

extension FirestoreAreasService: @unchecked Sendable {}
