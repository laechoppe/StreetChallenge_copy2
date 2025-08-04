//
//  SimplifiedDirectionsSection.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 06/06/2025.
//

import SwiftUI
import CoreLocation
import MapKit

struct DirectionsSection: View {
    let directions: String
    let center: CLLocationCoordinate2D

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            MapPreviewCard(center: center)

            directionsContent
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    // MARK: - Streamlined Directions Content
    private var directionsContent: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("How to get there")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.primary)
            VStack(alignment: .leading, spacing: 8) {
                ForEach(TransportType.allCases, id: \.self) { type in
                    TransportOptionRow(
                        icon: type.icon,
                        title: type.displayName,
                        description: type.actionDescription,
                        color: type.color,
                        action: { performAction(for: type) }
                    )
                }
            }
            .padding(.top, 8)
        }
    }

    private func performAction(for type: TransportType) {
        let coordinate = center
        let urlString: String

        switch type {
        case .walking:
            urlString = "http://maps.apple.com/?daddr=\(coordinate.latitude),\(coordinate.longitude)&dirflg=w"
        case .driving:
            urlString = "http://maps.apple.com/?daddr=\(coordinate.latitude),\(coordinate.longitude)&dirflg=d"
        case .cycling:
            urlString = "http://maps.apple.com/?daddr=\(coordinate.latitude),\(coordinate.longitude)&dirflg=b"
        case .bus, .tube, .train:
            urlString = "https://tfl.gov.uk/plan-a-journey/"
        }

        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
}

enum TransportType: CaseIterable {
    case bus, tube, train, walking, cycling, driving

    var color: Color {
        switch self {
        case .bus: return .red
        case .tube: return .blue
        case .train: return .green
        case .walking: return .orange
        case .cycling: return .mint
        case .driving: return .purple
        }
    }

    var displayName: String {
        switch self {
        case .bus: return "Bus"
        case .tube: return "Underground"
        case .train: return "Train"
        case .walking: return "Walking"
        case .cycling: return "Cycling"
        case .driving: return "Driving"
        }
    }

    var icon: String {
        switch self {
        case .bus: return "bus.fill"
        case .tube: return "tram.fill"
        case .train: return "train.side.front.car"
        case .walking: return "figure.walk"
        case .cycling: return "bicycle"
        case .driving: return "car.fill"
        }
    }

    var actionDescription: String {
        switch self {
        case .walking: return "Get walking directions"
        case .bus, .tube, .train: return "Plan your journey with TfL"
        case .cycling: return "Get cycling directions"
        case .driving: return "Get driving directions"
        }
    }

}

#Preview {
    ScrollView {
        DirectionsSection(
            directions: "Take the W7 or W3 bus from Finsbury Park station. You can also catch the 41 bus from Archway, or the 91 bus from King's Cross. From Highgate tube station, it's a pleasant 15-minute walk downhill through residential streets. Cycle from central London via quiet residential roads and park your bike on the High Street. Walk to the Clock Tower at the junction of The Broadway and Tottenham Lane. If driving, note that parking can be limited on weekends.",
            center: .init(latitude: 51.5924, longitude: -0.1203)
        )
        .padding()
    }
}
