//
//  AnswerServiceTests.swift
//  StreetChallenge
//
//  Created by Uladzislau on 01/08/2025.
//

import XCTest
import CoreData
@testable import StreetChallenge

class AnswerServiceTests: XCTestCase {
    
    var context: NSManagedObjectContext!
    var persistentContainer: NSPersistentContainer!
    
    override func setUp() {
        super.setUp()
        persistentContainer = NSPersistentContainer(name: "Answers")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        persistentContainer.persistentStoreDescriptions = [description]
        
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load store: \(error)")
            }
        }
        
        context = persistentContainer.viewContext
    }
    
    private func fetchAnswer(questionId: String) -> Answers? {
        let request: NSFetchRequest<Answers> = Answers.fetchRequest()
        request.predicate = NSPredicate(format: "questionId == %@", questionId)
        return try? context.fetch(request).first
    }
    
    func testSetAnswered_NewAnswer_CreatesEntity() {
        AnswerService.setAnswered(questionId: "question_1", isAnswered: true, context: context)
        
        let answer = fetchAnswer(questionId: "question_1")
        XCTAssertNotNil(answer)
        XCTAssertTrue(answer?.isAnswered ?? false)
    }
    
    func testSetAnswered_ExistingAnswer_UpdatesEntity() {
        let answer = Answers(context: context)
        answer.questionId = "question_2"
        answer.isAnswered = false
        try? context.save()
        
        AnswerService.setAnswered(questionId: "question_2", isAnswered: true, context: context)
        
        context.refresh(answer, mergeChanges: true)
        XCTAssertTrue(answer.isAnswered)
    }
    
    func testToggleAnswered_NoExistingAnswer_CreatesAnsweredEntity() {
        AnswerService.toggleAnswered(questionId: "toggle_1", context: context)
        
        let answer = fetchAnswer(questionId: "toggle_1")
        XCTAssertTrue(answer?.isAnswered ?? false)
    }
    
    func testToggleAnswered_ExistingAnswer_TogglesState() {
        let answer = Answers(context: context)
        answer.questionId = "toggle_2"
        answer.isAnswered = true
        try? context.save()
        
        AnswerService.toggleAnswered(questionId: "toggle_2", context: context)
        
        let updatedAnswer = fetchAnswer(questionId: "toggle_2")
        XCTAssertFalse(updatedAnswer?.isAnswered ?? true)
    }
}
