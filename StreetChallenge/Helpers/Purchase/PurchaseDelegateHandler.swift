//
//  PurchaseDelegateHandler.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 26/09/2024.
//

import Foundation
import RevenueCat
import Observation

@Observable
final class PurchasesDelegateHandler: NSObject, PurchasesDelegate {
    static let shared = PurchasesDelegateHandler()

    private override init() {
        super.init()
    }

    /**
     Whenever the `shared` instance of Purchases updates the CustomerInfo cache, this method will be called.

     - Note: CustomerInfo is not pushed to each Purchases client, it has to be fetched.
     This delegate method is only called when the SDK updates its cache after an app launch, purchase, restore, or fetch.
     You still need to call `Purchases.shared.customerInfo` to fetch CustomerInfo regularly.
     */
    func purchases(
        _ purchases: Purchases,
        receivedUpdated customerInfo: CustomerInfo
    ) {
        // Marshal back to MainActor for UI-bound updates
        Task { @MainActor in
            UserViewModel.shared.customerInfo = customerInfo
        }
    }

    /**
     - Note: this can be tested by opening a link like:
     itms-services://?action=purchaseIntent&bundleId=<BUNDLE_ID>&productIdentifier=<SKPRODUCT_ID>
     */
    func purchases(
        _ purchases: Purchases,
        readyForPromotedProduct product: StoreProduct,
        purchase startPurchase: @escaping StartPurchaseBlock
    ) {
        startPurchase { transaction, info, error, cancelled in
            Task { @MainActor in
                if let info = info, error == nil, !cancelled {
                    UserViewModel.shared.customerInfo = info
                }
            }
        }
    }
}

extension PurchasesDelegateHandler: @unchecked Sendable {}
