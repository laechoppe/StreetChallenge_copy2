//
//  AppInitializer.swift
//  StreetChallenge
//

import Foundation
import RevenueCat
import Observation

@MainActor
@Observable class AppInitializer {

    // MARK: - App State
    var isInitializing = true
    var initializationError: String?

    // MARK: - View Models (created after Firebase is ready)
    var questionsViewModel: QuestionsViewModel?
    var areasViewModel: AreasViewModel?
    var pointsOfInterestViewModel: PointsOfInterestViewModel?
    var imageLoader: ImageLoader?
    var locationHelper: LocationHelper?
    var userModel: UserViewModel?

    private var hasInitialized = false

    // MARK: - Initialization

    func initialize() async {
        guard !hasInitialized else {
            return
        }

        hasInitialized = true

        do {
            // Basic RevenueCat setup (lightweight)
            await setupRevenueCat()

            // Create view models now that Firebase is ready
            await createViewModels()

            // Initialize services in background
            await initializeServices()

            initializationError = nil

        } catch {
            initializationError = error.localizedDescription
        }

        isInitializing = false
    }

    // MARK: - Private Methods

    private func setupRevenueCat() async {
        Purchases.shared.delegate = PurchasesDelegateHandler.shared
    }

    private func createViewModels() async {
        questionsViewModel = QuestionsViewModel()
        areasViewModel = AreasViewModel()
        pointsOfInterestViewModel = PointsOfInterestViewModel()
        imageLoader = ImageLoader()
        locationHelper = LocationHelper()
        userModel = UserViewModel()
    }

    @MainActor
    private func initializeServices() async {
        guard let userModel = userModel,
              let areasViewModel = areasViewModel else { return }

        // Sync purchases
        async let syncResult: Void = {
            do {
                try await AsyncTimeoutHelper.withTimeout(seconds: 10) {
                    await userModel.syncPurchases()
                }
            } catch {
                print("AppInitializer: Purchase sync failed: \(error)")
            }
        }()

        // Load critical data
        async let dataResult: Void = {
            do {
                try await AsyncTimeoutHelper.withTimeout(seconds: 20) {
                    await areasViewModel.fetchData()
                }
            } catch {
                print("AppInitializer: Critical data loading failed: \(error)")
            }
        }()

        // Handle offerings fetch with proper error handling
        do {
            let rawOfferings = try await AsyncTimeoutHelper.withTimeout(seconds: 15) {
                try await Purchases.shared.offerings()
            }
            userModel.offerings = rawOfferings
        } catch {
            print("AppInitializer: Offerings fetch failed: \(error)")
        }

        // Wait for the other tasks
        _ = await (syncResult, dataResult)
    }


    func retry() async {
        hasInitialized = false
        isInitializing = true
        initializationError = nil
        await initialize()
    }
}
