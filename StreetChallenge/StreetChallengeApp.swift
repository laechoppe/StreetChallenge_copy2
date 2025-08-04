//
//  StreetChallengeApp.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 21/03/2022.
//

import SwiftUI

@main
struct StreetChallengeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var appInitializer = AppInitializer()
    @Environment(\.scenePhase) var scenePhase

    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            Group {
                if appInitializer.isInitializing {
                    AppLoadingView(
                        error: appInitializer.initializationError,
                        onRetry: {
                            Task {
                                await appInitializer.initialize()
                            }
                        }
                    )
                } else if let questionsViewModel = appInitializer.questionsViewModel,
                          let areasViewModel = appInitializer.areasViewModel,
                          let pointsOfInterestViewModel = appInitializer.pointsOfInterestViewModel,
                          let imageLoader = appInitializer.imageLoader,
                          let locationHelper = appInitializer.locationHelper,
                          let userModel = appInitializer.userModel {

                    ViewCoordinator()
                        .environment(questionsViewModel)
                        .environment(areasViewModel)
                        .environment(pointsOfInterestViewModel)
                        .environment(imageLoader)
                        .environment(locationHelper)
                        .environment(userModel)
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                } else {
                    // Fallback if view models aren't ready
                    AppLoadingView(
                        error: "Failed to initialize app components",
                        onRetry: {
                            Task {
                                await appInitializer.retry()
                            }
                        }
                    )
                }
            }
            .onChange(of: scenePhase) {
                persistenceController.save()
            }
            .task {
                await appInitializer.initialize()
            }
        }
    }
}
