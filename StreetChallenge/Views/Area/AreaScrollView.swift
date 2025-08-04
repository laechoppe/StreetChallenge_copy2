//
//  AreaScrollView.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 03/06/2025.
//
import SwiftUI

struct AreaScrollView: View {
    let areas: [Area]
    let geometry: GeometryProxy
    @Binding var selectedArea: Area?
    @Binding var navigateToQuestions: Bool
    @Binding var paywallPresented: Bool
    var userModel: UserViewModel
    let selectedOption: MenuOption

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 25) {
                ForEach(areas.indices, id: \.self) { index in
                    let area = areas[index]
                    AreaCardView(size: geometry.size, area: area, selectedOption: selectedOption)
                        .shadow(radius: 5, x: 5, y: 5)
                        .containerRelativeFrame(.horizontal)
                        .tag(index)
                        .scrollTransition { content, phase in
                            content
                                .opacity(phase.isIdentity ? 1 : 0.5)
                                .scaleEffect(y: phase.isIdentity ? 1 : 0.7)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            guard area.available else { return }
                            selectedArea = area
                            if area.premium && !userModel.subscriptionActive {
                                paywallPresented = true
                            } else {
                                navigateToQuestions = true
                            }
                        }
                }
            }
            .scrollTargetLayout()
        }
        .contentMargins(50, for: .scrollContent)
        .scrollTargetBehavior(.viewAligned)
    }
}
