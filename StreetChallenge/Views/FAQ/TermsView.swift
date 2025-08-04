//
//  TermsView.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 20/12/2023.
//

import SwiftUI

struct TermsView: View {
    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            NavBarCloseButton(title: "Terms and Conditions")
            ScrollView {
                Text(.init(terms))
                    .padding()
            }
        }
    }
}

struct TermsView_Previews: PreviewProvider {
    static var previews: some View {
        TermsView()
    }
}

