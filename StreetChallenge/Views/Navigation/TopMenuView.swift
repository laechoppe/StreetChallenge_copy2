//
//  TopMenuView.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 03/06/2025.
//
import SwiftUI

struct TopMenuView: View {
    @Binding var selectedOption: MenuOption
    @Binding var currentIndex: Int?
    @State private var navigateToSettings = false

    var body: some View {
        HStack {
            DynamicMenuLabelView(selectedOption: $selectedOption)
                .onChange(of: selectedOption) {
                    withAnimation { currentIndex = 0 }
                    HapticManager.triggerHaptic()
                }
            Spacer()
            Button {
                navigateToSettings = true
            } label: {
                Image(systemName: "gearshape.fill")
                    .font(.title2)
            }
        }
        .padding([.horizontal, .top])
        .navigationDestination(isPresented: $navigateToSettings) {
            SettingsView()
        }
    }
}
