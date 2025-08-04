//
//  BackButton.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 11/01/2025.
//

import SwiftUI

struct BackButtonView: View {

    var body: some View {
        Image(systemName: "arrow.left")
            .font(.headline)
            .padding()
            .background(Color.mainWhite.opacity(0.7))
            .clipShape(Circle())
    }
}
