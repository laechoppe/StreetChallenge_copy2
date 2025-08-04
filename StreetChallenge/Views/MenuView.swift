//
//  MenuView.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 06/02/2025.
//

import SwiftUI

enum MenuOption: String, CaseIterable {
    case treasureHunts = "Treasure Hunts"
    case walkingTours = "Walking Tours"

    var systemImage: String {
        switch self {
        case .walkingTours: return "figure.walk"
        case .treasureHunts: return "gamecontroller"
        }
    }
}

struct DynamicMenuLabelView: View {
    @Binding var selectedOption: MenuOption

    var body: some View {
        Menu {
            ForEach(MenuOption.allCases, id: \.self) { option in
                Button {
                    selectedOption = option
                } label: {
                    Label(option.rawValue, systemImage: option.systemImage)
                }
            }
        } label: {
            HStack(spacing: 8) {

                Text(selectedOption.rawValue)
                        .font(.title)
                        .fontWeight(.bold)
                        .fixedSize()

                Image(systemName: "chevron.down")
                    .font(.body)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
#Preview {
    DynamicMenuLabelView(selectedOption: .constant(.treasureHunts))
}
