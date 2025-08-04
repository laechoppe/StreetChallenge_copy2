//
//  AnswerService.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 24/07/2025.
//


import Foundation
import CoreData

struct AnswerService {
    static func setAnswered(questionId: String, isAnswered: Bool, context: NSManagedObjectContext) {
        let request: NSFetchRequest<Answers> = Answers.fetchRequest()
        request.predicate = NSPredicate(format: "questionId == %@", questionId)
        request.fetchLimit = 1
        
        do {
            let results = try context.fetch(request)
            
            if let existingAnswer = results.first {
                existingAnswer.isAnswered = isAnswered
            } else {
                let newAnswer = Answers(context: context)
                newAnswer.questionId = questionId
                newAnswer.isAnswered = isAnswered
            }
            
            try context.save()
        } catch {
            print("Failed to save answer: \(error)")
        }
    }
    
    static func toggleAnswered(questionId: String, context: NSManagedObjectContext) {
        let request: NSFetchRequest<Answers> = Answers.fetchRequest()
        request.predicate = NSPredicate(format: "questionId == %@", questionId)
        request.fetchLimit = 1
        
        do {
            let results = try context.fetch(request)
            let currentState = results.first?.isAnswered ?? false
            setAnswered(questionId: questionId, isAnswered: !currentState, context: context)
        } catch {
            print("Failed to fetch current answer state: \(error)")
        }
    }
}