//
//  NavigationDestinationView.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 03/06/2025.
//
import SwiftUI

struct NavigationDestinationView: View {
    let selectedArea: Area
    let selectedOption: MenuOption
    @Binding var paywallPresented: Bool

    var body: some View {
        if selectedOption == .walkingTours {
            AreaGuideIntroView(area: selectedArea, paywallPresented: $paywallPresented)
        } else {
            QuestionsListView(area: selectedArea, paywallPresented: $paywallPresented)
        }
    }
}
