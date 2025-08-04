//
//  QuestionsFetcher.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 29/09/2024.
//

import FirebaseFirestore
import CoreLocation

protocol QuestionsDataFetching: Sendable {
    func fetchQuestions() async throws -> [Question]
}

class FirestoreQuestionsService: QuestionsDataFetching {
    private var db = Firestore.firestore()

    func fetchQuestions() async throws -> [Question] {
        var fetchedQuestions: [Question] = []
        let snapshot = try await db.collection("Questions").getDocuments()

        for document in snapshot.documents {
            let data = document.data()

            let id = data["id"] as? String ?? ""
            let globalId = data["globalId"] as? String ?? ""
            let questionText = data["questionText"] as? String ?? ""
            let answerText = data["answerText"] as? String ?? ""
            let answerImageUrl = data["answerImageUrl"] as? String ?? ""
            let commentText = data["commentText"] as? String ?? ""
            let areaId = data["areaId"] as? String ?? ""
            let areaName = data["areaName"] as? String ?? ""
            let cityId = data["cityId"] as? String ?? ""
            let cityName = data["cityName"] as? String ?? ""
            let imageName = data["imageName"] as? String ?? ""
            let answerGeoPoint = data["answerCoordinate"] as? GeoPoint

            let question = QuestionViewModel.createQuestion(
                id: id,
                globalId: globalId,
                questionText: questionText,
                answerText: answerText,
                answerImageUrl: answerImageUrl,
                commentText: commentText,
                areaId: areaId,
                areaName: areaName,
                cityId: cityId,
                cityName: cityName,
                imageName: imageName,
                userAnswer: nil,
                answerGeoPoint: answerGeoPoint
            )

            fetchedQuestions.append(question)
        }

        return fetchedQuestions
    }
}

extension FirestoreQuestionsService: @unchecked Sendable {}
