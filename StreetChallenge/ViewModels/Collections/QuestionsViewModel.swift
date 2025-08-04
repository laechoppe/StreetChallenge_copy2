//
//  QuestionsViewModel.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 18/12/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import CoreLocation

@MainActor
@Observable class QuestionsViewModel {
    var questions: [Question] = []
    var isLoading: Bool = false
    var errorMessage: String?

    private let dataService: QuestionsDataFetching

    init(dataService: QuestionsDataFetching = FirestoreQuestionsService()) {
        self.dataService = dataService
    }

    func fetchData() async {
        isLoading = true
        errorMessage = nil

        do {
            let fetchedQuestions = try await dataService.fetchQuestions()
            DispatchQueue.main.async {
                self.questions = fetchedQuestions
                self.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Failed to fetch questions: \(error.localizedDescription)"
                self.isLoading = false
            }
        }
    }

    func resetAnswers(questionsGlobalIds: [String]) {
        questionsGlobalIds.forEach { questionGlobalId in
            UserDefaults.standard.set(false, forKey: questionGlobalId)
        }
    }
}
