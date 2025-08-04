//
//  QuestionViewModelTests.swift
//  StreetChallenge
//
//  Created by Uladzislau on 01/08/2025.
//

import XCTest
import Foundation
import CoreLocation
import FirebaseFirestore
@testable import StreetChallenge

class QuestionViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        clearUserDefaults()
    }
    
    override func tearDown() {
        clearUserDefaults()
        super.tearDown()
    }
    
    private func clearUserDefaults() {
        let userDefaults = UserDefaults.standard
        let keys = ["test_question_1", "answered_question", "unanswered_question"]
        keys.forEach { userDefaults.removeObject(forKey: $0) }
    }
    
    func testLoadAnsweredState_WhenQuestionNotAnswered_ReturnsFalse() {
        let questionId = "unanswered_question"
        let result = QuestionViewModel.loadAnsweredState(for: questionId)
        XCTAssertFalse(result)
    }
    
    func testLoadAnsweredState_WhenQuestionAnswered_ReturnsTrue() {
        let questionId = "answered_question"
        UserDefaults.standard.set(true, forKey: questionId)
        let result = QuestionViewModel.loadAnsweredState(for: questionId)
        XCTAssertTrue(result)
    }
    
    func testSaveAnsweredStateToUserDefaults_SavesCorrectly() {
        let questionId = "test_question_1"
        QuestionViewModel.saveAnsweredStateToUserDefaults(for: questionId, state: true)
        let savedState = UserDefaults.standard.bool(forKey: questionId)
        XCTAssertTrue(savedState)
    }
    
    func testSaveAnsweredStateToUserDefaults_OverwritesExistingValue() {
        let questionId = "test_question_1"
        UserDefaults.standard.set(false, forKey: questionId)
        QuestionViewModel.saveAnsweredStateToUserDefaults(for: questionId, state: true)
        let savedState = UserDefaults.standard.bool(forKey: questionId)
        XCTAssertTrue(savedState)
    }
    
    func testCreateQuestion_WithValidParameters_CreatesQuestionCorrectly() {
        let geoPoint = GeoPoint(latitude: 48.8566, longitude: 2.3522)
        
        let question = QuestionViewModel.createQuestion(
            id: "test_id",
            globalId: "global_test_id",
            questionText: "What is the capital of France?",
            answerText: "Paris",
            answerImageUrl: "https://example.com/image.jpg",
            commentText: "This is a comment",
            areaId: "area_1",
            areaName: "Europe",
            cityId: "city_1",
            cityName: "Paris",
            imageName: "eiffel_tower",
            userAnswer: nil,
            answerGeoPoint: geoPoint
        )
        
        XCTAssertEqual(question.id, "test_id")
        XCTAssertEqual(question.globalId, "global_test_id")
        XCTAssertEqual(question.questionText, "What is the capital of France?")
        XCTAssertEqual(question.answerText, "Paris")
        XCTAssertEqual(question.answerImageUrl?.absoluteString, "https://example.com/image.jpg")
        XCTAssertNotNil(question.answerCoordinate)
        XCTAssertEqual(Double(question.answerCoordinate!.latitude), 48.8566, accuracy: 0.0001)
        XCTAssertEqual(Double(question.answerCoordinate!.longitude), 2.3522, accuracy: 0.0001)
    }
    
    func testCreateQuestion_WithNewlineCharacters_ReplacesCorrectly() {
        let question = QuestionViewModel.createQuestion(
            id: "test",
            globalId: "global_test",
            questionText: "Line 1\\nLine 2\\nLine 3",
            answerText: "Answer",
            answerImageUrl: "https://example.com/image.jpg",
            commentText: "Comment",
            areaId: "area",
            areaName: "Area",
            cityId: "city",
            cityName: "City",
            imageName: "image",
            userAnswer: nil,
            answerGeoPoint: nil
        )
        
        XCTAssertEqual(question.questionText, "Line 1\nLine 2\nLine 3")
    }
    
    func testCreateQuestion_WithNilGeoPoint_SetsNilCoordinate() {
        let question = QuestionViewModel.createQuestion(
            id: "test",
            globalId: "global_test",
            questionText: "Question",
            answerText: "Answer",
            answerImageUrl: "https://example.com/image.jpg",
            commentText: "Comment",
            areaId: "area",
            areaName: "Area",
            cityId: "city",
            cityName: "City",
            imageName: "image",
            userAnswer: nil,
            answerGeoPoint: nil
        )
        
        XCTAssertNil(question.answerCoordinate)
    }
}
