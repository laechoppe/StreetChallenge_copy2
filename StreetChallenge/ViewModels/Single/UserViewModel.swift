//
//  UserViewModel.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 26/09/2024.
//

import Foundation
import RevenueCat

/* Static shared model for UserView */
@MainActor
@Observable class UserViewModel: @unchecked Sendable {
    static let shared = UserViewModel()

    /* The latest CustomerInfo from RevenueCat. Updated by PurchasesDelegate whenever the Purchases SDK updates the cache */
    var customerInfo: CustomerInfo? {
        didSet {
            subscriptionActive = customerInfo?.entitlements[Constants.entitlementID]?.isActive == true
        }
    }

    /* The latest offerings - fetched from MagicWeatherApp.swift on app launch */
    var offerings: Offerings?

    /* Set from the didSet method of customerInfo above, based on the entitlement set in Constants.swift */
    var subscriptionActive: Bool = false

    // Sync manually - converted to async
    func syncPurchases() async {
        do {
            let customerInfo = try await Purchases.shared.syncPurchases()
            self.customerInfo = customerInfo
        } catch {
            print("Error fetching customer info: \(error.localizedDescription)")
        }
    }
}
