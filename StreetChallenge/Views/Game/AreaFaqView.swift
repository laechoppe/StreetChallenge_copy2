//
//  AreaFaqView.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 19/12/2023.
//

import SwiftUI

struct AreaFaqView: View {
    var area: Area
    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>
    @State private var expanded: Bool = true

    var body: some View {
        VStack {
            NavBarCloseButton(title: "FAQ")
            VStack {
                DisclosureGroup("Buttons", isExpanded: $expanded) {
                    ButtonsFAQView()
                }

                DisclosureGroup("Rules", isExpanded: $expanded) {
                    Text(.init(rules))
                }
            }
            .padding()
            Spacer()

        }

    }
}

struct AreaFaqView_Previews: PreviewProvider {
    static var previews: some View {
        AreaFaqView(area: mockArea)
    }
}
