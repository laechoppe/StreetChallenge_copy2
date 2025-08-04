//
//  OnboardingView.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 20/12/2023.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("isOnboarding") var isOnboarding: Bool?

    var body: some View {
        ZStack {
            Image("anyStreet")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .blur(radius: 2)
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.black.opacity(0.3),
                            Color.black.opacity(0.6)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            VStack(spacing: 0) {
                Spacer()

                VStack(spacing: 32) {
                    VStack(spacing: 20) {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.system(size: 60, weight: .light))
                            .foregroundColor(.white)
                            .opacity(0.9)

                        VStack(spacing: 32) {
                            Text("Welcome to\nStreet Challenge")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)

                            Text("Discover hidden gems, solve challenges, and explore your city like never before.")
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundColor(.white.opacity(0.9))
                        }
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)

                    }
                    .padding(.top, 32)
                    .padding(.horizontal, 32)

                    Spacer()
                        .frame(minHeight: 40, maxHeight: 80)
                    MainButton(title: "Get Started", colour: .white, action: { isOnboarding = false })
                }

                Spacer()
                    .frame(minHeight: 60)

                Footer()
                    .padding(.horizontal, 32)
                    .padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    OnboardingView()
}

//Clear user defaults with:
//let domain = Bundle.main.bundleIdentifier!
//UserDefaults.standard.removePersistentDomain(forName: domain)
//UserDefaults.standard.synchronize()
//print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
