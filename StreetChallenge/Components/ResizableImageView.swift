//
//  ResizableImageView.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 11/01/2025.
//

import SwiftUI

struct ResizableImageView: View {
    let image: UIImage

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
    }
}
