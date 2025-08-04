//
//  AppDelegate.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 22/06/2025.
//

import UIKit
import Firebase
import TipKit
import RevenueCat

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
                
        configureFirebase()
        configureTips()
        configureRevenueCat()
        configureNetworking()
        startAnonymousAuth()
        
        return true
    }
    
    // MARK: - Private Configuration Methods
    
    private func configureFirebase() {
        FirebaseApp.configure()
        
        let settings = FirestoreSettings()
        settings.cacheSettings = PersistentCacheSettings(
            sizeBytes: FirestoreCacheSizeUnlimited as NSNumber
        )
        Firestore.firestore().settings = settings
    }
    
    private func configureTips() {
        do {
            try Tips.configure()
        } catch {
            print("AppDelegate: Tips configuration failed: \(error)")
        }
    }
    
    private func configureRevenueCat() {
        Purchases.logLevel = .error
        
        Purchases.configure(
            with: Configuration.Builder(withAPIKey: Constants.apiKey)
                .with(storeKitVersion: .storeKit2)
                .build()
        )
    }
    
    private func configureNetworking() {
        
        // Enhanced image cache configuration
        URLCache.shared.memoryCapacity = 20 * 1024 * 1024   // 20MB
        URLCache.shared.diskCapacity = 50 * 1024 * 1024     // 50MB
        
        // Configure default URLSession
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 60
        configuration.waitsForConnectivity = true
        configuration.requestCachePolicy = .returnCacheDataElseLoad
    }
    
    private func startAnonymousAuth() {
        Task {
            do {
                let result = try await Auth.auth().signInAnonymously()
                let uid = result.user.uid
            } catch {
                print("AppDelegate: Anonymous sign-in failed: \(error.localizedDescription)")
            }
        }
    }
}
