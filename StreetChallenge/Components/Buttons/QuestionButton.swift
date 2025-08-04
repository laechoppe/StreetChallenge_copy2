//
//  QuestionButton.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 02/04/2022.
//

import SwiftUI

struct QuestionButton: View {
    @Binding var selectedButton: String
    var item: String
    var area: Area

    var body: some View {
            ZStack {
                TileImageView(url: area.imageUrl, size: .init(width: 150, height: 150))
                    .brightness(-0.3)
                Text(item)
                    .font(.title)
                    .dynamicTypeSize(.large)
                    .foregroundColor(Color.white)
                    .shadow(radius: 1)
            }
    }
}

struct QuestionButton_Previews: PreviewProvider {
    @State static var selectedButton: String = "1"

    static let area: Area = mockArea

    static var previews: some View {
        Group {
            QuestionButton(
                selectedButton: self.$selectedButton,
                item: "1",
                area: area
            )
        }
    }
}
