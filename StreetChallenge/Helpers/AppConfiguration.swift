//
//  AppConfiguration.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 22/06/2025.
//

import Foundation

enum AppConfiguration {
    
    // MARK: - Timeout Constants
    enum Timeouts {
        static let purchaseSync: TimeInterval = 10
        static let offeringssFetch: TimeInterval = 15
        static let criticalDataLoad: TimeInterval = 20
        static let networkRequest: TimeInterval = 30
        static let networkResource: TimeInterval = 60
    }
    
    // MARK: - Cache Configuration
    enum Cache {
        static let memoryCapacity = 20 * 1024 * 1024   // 20MB
        static let diskCapacity = 50 * 1024 * 1024     // 50MB
    }
    
    // MARK: - Network Configuration
    enum Network {
        static let requestTimeout: TimeInterval = 30
        static let resourceTimeout: TimeInterval = 60
        static let waitsForConnectivity = true
    }
    
    // MARK: - Debug Configuration
    enum Debug {
        static let enableVerboseLogging = true
        static let logNetworkRequests = false
        static let logViewModelOperations = true
    }
}

// MARK: - App State

enum AppState {
    case initializing
    case ready
    case error(String)
    
    var isInitializing: Bool {
        if case .initializing = self {
            return true
        }
        return false
    }
    
    var errorMessage: String? {
        if case .error(let message) = self {
            return message
        }
        return nil
    }
}
