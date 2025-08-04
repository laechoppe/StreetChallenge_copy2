//
//  MiniMapView.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 05/10/2024.
//

import SwiftUI

struct MiniMapView: View {
    var answerCoordinate: MapCentrePoint
    var openedForAnswer: Bool = true
    var title: String
    @Binding var isPresented: Bool

    var body: some View {
        MapViewArea(
            openedForAnswer: openedForAnswer,
            mapCentrePoint: answerCoordinate
        )
        .onTapGesture {
            self.isPresented.toggle()
        }
        .fullScreenCover(isPresented: $isPresented) {
            MapAllView(
                openedForAnswer: openedForAnswer,
                title: title,
                answerCoordinate: answerCoordinate
            )
        }
    }
}

#Preview {
    MiniMapView(
        answerCoordinate: MapCentrePoint(centre: mockAreaCenter),
        title: "Crouch end",
        isPresented: .constant(false)
    )
}
