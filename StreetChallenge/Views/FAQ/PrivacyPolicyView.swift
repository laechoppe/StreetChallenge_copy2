//
//  PrivacyPolicyView.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 20/12/2023.
//

import SwiftUI

struct PrivacyPolicyView: View {
    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            NavBarCloseButton(title: "Privacy Policy")
            ScrollView {
                Text(.init(privacy))
                    .padding()
            }
        }
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
