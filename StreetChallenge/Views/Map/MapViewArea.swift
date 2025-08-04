//
//  MapView.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 30/12/2023.
//

import SwiftUI
import MapKit

struct MapViewArea: View {
    @State private var region: MKCoordinateRegion
    var mapCentrePoint: MapCentrePoint?
    var openedForAnswer: Bool

    init(
        openedForAnswer: Bool,
        mapCentrePoint: MapCentrePoint
    ) {
        let delta = openedForAnswer ? 0.005 : 0.01
        self.openedForAnswer = openedForAnswer
        self.mapCentrePoint = mapCentrePoint
        self._region = State(
            initialValue: MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: mapCentrePoint.latitude,
                    longitude: mapCentrePoint.longitude
                ),
                span: MKCoordinateSpan(
                    latitudeDelta: delta,
                    longitudeDelta: delta
                )
            )
        )
    }
    
    var body: some View {

        var cameraPosition: MapCameraPosition {
            MapCameraPosition.region(region)
        }

        Map(
            position: .constant(cameraPosition),
            bounds: nil,
            interactionModes: .all,
            scope: nil
        ) {
            if let mapCentrePoint, openedForAnswer {
                Marker(
                    "Answer is here!",
                    coordinate: .init(
                        latitude: mapCentrePoint.latitude,
                        longitude: mapCentrePoint.longitude
                    )
                )
                .tint(Color.blue)
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapViewArea(
            openedForAnswer: false,
            mapCentrePoint: MapCentrePoint(centre: mockAreaCenter)
        )
    }
}
