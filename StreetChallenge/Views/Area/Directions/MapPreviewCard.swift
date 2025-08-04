//
//  miniMap.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 11/06/2025.
//

import SwiftUI
import MapKit

struct MapPin: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct MapPreviewCard: View {
    @State private var cameraPosition: MapCameraPosition
    let center: CLLocationCoordinate2D

    init(center: CLLocationCoordinate2D) {
        self.center = center
        self._cameraPosition = State(initialValue: .region(MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: center.latitude,
                longitude: center.longitude
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0.01,
                longitudeDelta: 0.01
            )
        )))
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {

            Map(position: $cameraPosition, interactionModes: .all) {
                Marker("", coordinate: center)
                    .tint(Color.red)
            }
            .frame(height: 160)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .allowsHitTesting(false)

            // Overlay with tap action
            Color.clear
                .frame(height: 160)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .onTapGesture {
                    openInAppleMaps()
                }

            openInAppleMapsButton
            .padding(12)
        }
    }

    var openInAppleMapsButton: some View {
        Button(action: openInAppleMaps) {
            HStack(spacing: 6) {
                Image(systemName: "arrow.up.right")
                    .font(.system(size: 12, weight: .semibold))
                Text("Open in Maps")
                    .font(.system(size: 14, weight: .semibold))
            }
            .foregroundColor(.mainBlack)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(.ultraThickMaterial)
            .clipShape(Capsule())
            .shadow(radius: 2)
        }
    }

    // MARK: - Helper Functions
    private func openInAppleMaps() {
        let urlString = "http://maps.apple.com/?daddr=\(center.latitude),\(center.longitude)"
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
}
