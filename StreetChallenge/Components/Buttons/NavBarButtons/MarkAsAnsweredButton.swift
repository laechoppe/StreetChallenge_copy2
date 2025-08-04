//
//  MarkAsAnsweredButton.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 30/05/2024.
//

import SwiftUI

struct MarkAsAnsweredButton: View {
    @FetchRequest private var answers: FetchedResults<Answers>
    @Environment(\.managedObjectContext) private var context

    let questionId: String

    init(questionId: String) {
        self.questionId = questionId
        self._answers = FetchRequest(
            sortDescriptors: [],
            predicate: NSPredicate(format: "questionId == %@", questionId)
        )
    }

    private var isAnswered: Bool {
        answers.first?.isAnswered ?? false
    }

    var body: some View {
        Button(action: {
            HapticManager.triggerHaptic()
            AnswerService.toggleAnswered(questionId: questionId, context: context)
        }) {
            Image(systemName: "checkmark.circle")
                .foregroundColor(isAnswered ? .buttonBackground : .mainBlack)
        }
    }
}

struct MarkAsAnsweredButton_Previews: PreviewProvider {
    static var previews: some View {
        MarkAsAnsweredButton(questionId: "001")
    }
}
