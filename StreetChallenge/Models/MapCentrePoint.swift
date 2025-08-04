//
//  MapCentrePoint.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 04/10/2024.
//
import MapKit

struct MapCentrePoint {
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees

    var centre: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    init(centre: CLLocationCoordinate2D) {
        self.latitude = centre.latitude
        self.longitude = centre.longitude
    }

    init(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
