//
//  QuestionViewModel.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 31/05/2024.
//

import Foundation
import CoreLocation
import FirebaseFirestore

class QuestionViewModel {
    static func loadAnsweredState(for questionWithGlobalId: String) -> Bool {
        return UserDefaults.standard.bool(forKey: questionWithGlobalId)
    }
    
    static func saveAnsweredStateToUserDefaults(for questionWithGlobalId: String, state: Bool) {
        UserDefaults.standard.set(state, forKey: questionWithGlobalId)
    }

    static func createQuestion(
        id: String,
        globalId: String,
        questionText: String,
        answerText: String,
        answerImageUrl:String,
        commentText: String,
        areaId: String,
        areaName: String,
        cityId: String,
        cityName: String,
        imageName: String,
        userAnswer: String?,
        answerGeoPoint: GeoPoint?
    ) -> Question {
        
        var answerCoordinate: CLLocationCoordinate2D? = nil
        if let answerGeoPoint {
            let latitude = answerGeoPoint.latitude
            let longitude = answerGeoPoint.longitude
            if latitude != 0 && longitude != 0 {
                answerCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            }
        }
        
        return Question(
            id: id,
            globalId: globalId,
            questionText: questionText.replacingOccurrences(of: "\\n", with: "\n"),
            answerText: answerText,
            answerImageUrl: URL(string: answerImageUrl),
            commentText: commentText,
            areaId: areaId,
            areaName: areaName,
            cityId: cityId,
            cityName: cityName,
            imageName: imageName,
            userAnswer: nil,
            answerCoordinate: answerCoordinate
        )

    }
}
