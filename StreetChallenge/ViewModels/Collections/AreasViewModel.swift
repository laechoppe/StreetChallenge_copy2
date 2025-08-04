//
//  AreasViewModel.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 27/05/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import CoreLocation

@MainActor
@Observable class AreasViewModel {
    var areas: [Area] = []
    var isLoading: Bool = false
var errorMessage: String?

    private let dataService: AreasDataFetching
    private var retryCount = 0
    private let maxRetries = 3

    init(dataService: AreasDataFetching = FirestoreAreasService()) {
        self.dataService = dataService
    }

    func fetchData() async {
        isLoading = true
        errorMessage = nil

        do {
            let fetchedAreas = try await dataService.fetchAreas()
            areas = fetchedAreas.filter { !$0.isTest }
            isLoading = false
            retryCount = 0

        } catch {
            await handleError(error)
        }
    }

    private func handleError(_ error: Error) async {

        if retryCount < maxRetries {
            retryCount += 1
            let delay = Double(retryCount * 2)

            try? await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
            await fetchData()
            return
        }

        errorMessage = "Failed to fetch areas: \(error.localizedDescription)"
        isLoading = false
        retryCount = 0
    }
}
