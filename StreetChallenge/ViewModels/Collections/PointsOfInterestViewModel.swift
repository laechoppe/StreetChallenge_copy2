//
//  PointsOfInterestsViewModel.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 30/10/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import CoreLocation

@MainActor
@Observable class PointsOfInterestViewModel {
    var pointsOfInterest: [PointOfInterest] = []
    var isLoading: Bool = false
    var errorMessage: String?

    private let dataService: GuidesDataFetching

    init(dataService: GuidesDataFetching = FirestoreGuidesService()) {
        self.dataService = dataService
    }

    func fetchData() async {
        isLoading = true
        errorMessage = nil

        do {
            let fetchedPointsOfInterest = try await dataService.fetchPointsOfInterest()
            DispatchQueue.main.async {
                self.pointsOfInterest = fetchedPointsOfInterest
                self.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Failed to fetch Points Of Interest: \(error.localizedDescription)"
                self.isLoading = false
            }
        }
    }
}
