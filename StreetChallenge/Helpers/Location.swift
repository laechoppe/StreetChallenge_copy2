//
//  Location.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 06/06/2022.
//

import Foundation
import CoreLocation

@Observable class LocationHelper: NSObject, CLLocationManagerDelegate {
    static let DefaultLocation = CLLocationCoordinate2D(latitude: MapDefaults.latitude, longitude: MapDefaults.longitude)

    var userLocation: CLLocationCoordinate2D = DefaultLocation
    var locationPermissionGranted: Bool = false

    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Location manager changed the status: \(status)")
        handleAuthorizationStatus(status)
    }

    func requestLocationIfNeeded() {
        let status = locationManager.authorizationStatus
        handleAuthorizationStatus(status)
    }

    private func handleAuthorizationStatus(_ status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()

        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            locationPermissionGranted = true
        case .denied, .restricted:
            locationPermissionGranted = false
            self.userLocation = Self.DefaultLocation
            print("Location access denied. Consider showing settings prompt.")

        @unknown default:
            break
        }
    }

}

struct Location: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}
