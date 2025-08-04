//
//  Question.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 16/06/2024.
//

import SwiftUI

struct QuestionView: View {
    @State var question: Question

    var body: some View {
        Text(question.questionText)
            .padding()
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(question: mockQuestion)
    }
}
