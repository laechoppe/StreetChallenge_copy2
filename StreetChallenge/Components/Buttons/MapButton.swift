//
//  MapButton.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 19/12/2023.
//

import SwiftUI
import MapKit

struct MapButton: View {
    @Binding var isPresented: Bool
    var answerCoordinate: MapCentrePoint
    var title: String

    var body: some View {
        MainButton(title: "See on a map") {
            self.isPresented.toggle()
        }
        .fullScreenCover(isPresented: $isPresented) {
            MapAllView(
                openedForAnswer: true,
                title: title,
                answerCoordinate: answerCoordinate
            )
        }
    }
}

struct MapButton_Previews: PreviewProvider {
    static var previews: some View {
        MapButton(
            isPresented: .constant(false),
            answerCoordinate: MapCentrePoint(centre: mockAreaCenter),
            title: "Crouch end"
        )
    }
}
