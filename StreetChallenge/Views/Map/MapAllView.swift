//
//  MapAllView.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 07/06/2022.
//
import CoreData
import SwiftUI
import MapKit

struct MapAllView: View {
    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>
    var openedForAnswer: Bool
    var pinLabelInMaps: String = "&q=Answer is here!"
    var title: String
    var answerCoordinate: MapCentrePoint

    var body: some View {
        let urLString = "maps://?ll=\(answerCoordinate.latitude),\(answerCoordinate.longitude)"
        VStack {
            NavBarCloseButton(title: title)
            ZStack(alignment: .topTrailing) {
                MapViewArea(
                    openedForAnswer: openedForAnswer,
                    mapCentrePoint: answerCoordinate
                )
                VStack() {
                    Spacer()
                    MainButton(title: "Open in Maps") {
                        let url = URL(
                            string: openedForAnswer ? urLString + pinLabelInMaps : urLString
                        )
                        if UIApplication.shared.canOpenURL(url!) {
                            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

//struct MapAllView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            MapAllView(area: mockArea, openedForAnswer: false)
//                .previewDisplayName("Area")
//            
//            MapAllView(area: mockArea, openedForAnswer: true)
//                .previewDisplayName("Answer")
//        }
//    }
//}
