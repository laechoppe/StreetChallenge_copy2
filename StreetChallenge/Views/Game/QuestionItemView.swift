//
//  QuestionItemView.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 31/05/2024.
//

import SwiftUI

struct QuestionItemView: View {
    @FetchRequest private var answers: FetchedResults<Answers>
    @Environment(\.managedObjectContext) private var context
    @State var selectedButton = ""

    let question: Question
    let area: Area
    @Binding var selectedQuestion: Question?
    @Binding var isShowingDetailView: Bool
    @State private var isPressed = false

    private var answered: Bool {
        answers.first?.isAnswered ?? false
    }

    init(
        question: Question,
        area: Area,
        selectedQuestion: Binding<Question?>,
        isShowingDetailView: Binding<Bool>
    ) {
        self.question = question
        self.area = area
        self._selectedQuestion = selectedQuestion
        self._isShowingDetailView = isShowingDetailView

        self._answers = FetchRequest(
            sortDescriptors: [],
            predicate: NSPredicate(format: "questionId == %@", question.globalId)
        )
    }

    var body: some View {
        ZStack {
            QuestionButton(
                selectedButton: $selectedButton,
                item: question.id,
                area: area
            )
            .scaleEffect(isPressed ? 0.9 : 1.0)
            .animation(.spring(), value: isPressed)
            .sensoryFeedback(.start, trigger: isPressed)

            .onTapGesture {
                self.isPressed.toggle()
                selectedButton = question.id
                selectedQuestion = question
                isShowingDetailView = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.isPressed.toggle()
                    selectedButton = ""
                }
            }
            .overlay(
                VStack{
                    Spacer()
                    HStack {
                        Spacer()
                        imageOnButton()
                            .offset(x:  10, y:  10)
                    }
                }
            )
            .animation(.easeInOut, value: answered)
            .shadow(color: .gray.opacity(0.4), radius: 4, x: 2, y: 2)
        }
        .padding()
    }

    @ViewBuilder
    private func imageOnButton() -> some View {
        Circle()
            .fill(Color.mainWhite)
            .frame(width: 40, height: 40)
            .overlay(
                Image(systemName: imageForButton(item: question.id, answered: answered))
                    .foregroundColor(answered ? Color.buttonBackground : Color.mainBlack)
                    .shadow(radius: 1)
                    .font(.title2)
            )
    }

    func imageForButton(item: String, answered: Bool) -> String {
        return answered ? "checkmark" : "questionmark"
    }
}

struct QuestionItemView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            QuestionItemView(
                question: mockQuestion,
                area: mockArea,
                selectedQuestion: .constant(mockQuestion),
                isShowingDetailView: .constant(false)
            )

            QuestionItemView(
                question: mockQuestion,
                area: mockArea,
                selectedQuestion: .constant(mockQuestion2),
                isShowingDetailView: .constant(true)
            )
        }
        .environment(ImageLoader())
    }
}
