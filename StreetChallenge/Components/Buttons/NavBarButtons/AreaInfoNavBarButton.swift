//
//  MapNavBarButton.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 30/12/2023.
//

import SwiftUI

struct AreaInfoNavBarButton: View {
    @Binding var isPresented: Bool
    var area: Area

    var body: some View {
        Button(action: {
            self.isPresented.toggle()
        }, label: {
            Image(systemName: "info.square").foregroundColor(.mainBlack)
        })
        .sheet(isPresented: $isPresented, content: {
            MapAllView(
                openedForAnswer: false,
                title: area.name,
                answerCoordinate: MapCentrePoint(centre: area.center)
            )
            ScrollView {
                Text(.init(area.faq))
                    .padding()
            }
        })
    }
}

struct MapNavBarButton_Previews: PreviewProvider {
    static var previews: some View {
        AreaInfoNavBarButton(isPresented: .constant(true), area: mockArea)
    }
}
