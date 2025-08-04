//
//  Question.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 18/12/2023.
//

import Foundation
import CoreLocation

struct Question: Identifiable, Hashable {
    static func == (lhs: Question, rhs: Question) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    var id: String
    var globalId: String
    var questionText: String
    var answerText: String
    var answerImageUrl: URL?
    var commentText: String
    var areaId: String
    var areaName: String
    var cityId: String
    var cityName: String
    var imageName: String?
    var userAnswer: Answer?
    var answerCoordinate: CLLocationCoordinate2D?
    var answered: Bool?
}
