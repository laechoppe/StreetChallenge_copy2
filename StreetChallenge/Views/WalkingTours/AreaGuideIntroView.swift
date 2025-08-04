//
//  AreaGuideIntroView.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 30/10/2024.
//
import SwiftUI

struct AreaGuideIntroView: View {
    @Environment(PointsOfInterestViewModel.self) private var pointsOfInterestViewModel: PointsOfInterestViewModel
    @Environment(UserViewModel.self) private var userModel: UserViewModel
    @Environment(ImageLoader.self) private var imageLoader: ImageLoader
    @Environment(\.dismiss) private var dismiss

    var area: Area
    @Binding var paywallPresented: Bool

    @State private var navigateToGuide = false
    @State private var currentTab = 0

    private let headerHeight: CGFloat = UIScreen.main.bounds.height * 0.33
    private let bottomPadding: CGFloat = UIScreen.main.bounds.height * 0.14

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 0) {
                    AreaGuideHeaderView(
                        area: area
                    )

                    content
                        .padding(.horizontal)
                        .padding(.top)
                        .padding(.bottom, bottomPadding)
                }
            }

            MainButton(title: "Start the tour", colour: .mainWhite) {
                navigateToGuide = true
            }
            .padding(.bottom)
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            if let url = area.imageUrl {
                imageLoader.loadImage(from: url)
            }
        }
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $navigateToGuide) {
            AreaGuideDetailsView(area: area)
        }
        .overlay(backButtonOverlay, alignment: .topLeading)
    }

    private var content: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(area.name)
                .font(.largeTitle)

            Picker("", selection: $currentTab) {
                Text("About").tag(0)
                Text("Directions").tag(1)
                Text("Tips").tag(2)
            }
            .pickerStyle(.segmented)
            .padding(.bottom)

            tabContent
        }
    }

    @ViewBuilder
    private var tabContent: some View {
        switch currentTab {
        case 0:
            AboutSection(text: area.faq)
        case 1:
            DirectionsSection(directions: area.directions, center: area.center)
        case 2:
            TipsSection()
        default:
            AboutSection(text: area.faq)
        }
    }

    private var backButtonOverlay: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                BackButtonView()
            }
            Spacer()
        }
        .padding(.horizontal)
    }

    private func checkSubscription() {
        if !userModel.subscriptionActive {
            paywallPresented.toggle()
        }
    }

}

#Preview {
    let pointsOfInterestViewModel: PointsOfInterestViewModel = {
        let viewModel = PointsOfInterestViewModel()
        viewModel.pointsOfInterest = [mockPoi1, mockPoi2]
        return viewModel
    }()

    AreaGuideIntroView(
        area: mockArea,
        paywallPresented: .constant(false)
    )
    .environment(pointsOfInterestViewModel)
    .environment(ImageLoader())
}
