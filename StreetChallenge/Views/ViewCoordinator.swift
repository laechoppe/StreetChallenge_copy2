//
//  ViewCoordinator.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 22/12/2023.
//

import SwiftUI

struct ViewCoordinator: View {
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    @Environment(AreasViewModel.self) private var areasViewModel: AreasViewModel
    @Environment(LocationHelper.self) private var locationHelper: LocationHelper

    var body: some View {
        NavigationStack {
            if isOnboarding {
                OnboardingView()
            } else {
                if areasViewModel.isLoading {
                    ProgressView("Loading Areas...")
                } else if let errorMessage = areasViewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                } else {
                    MainView(guideMode: true)
                }
            }
        }
        .onAppear {
            Task {
               // locationHelper.requestLocationIfNeeded()
                await areasViewModel.fetchData()
            }
        }
    }
}

struct ViewCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        ViewCoordinator()
    }
}
