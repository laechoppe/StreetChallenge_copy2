//
//  QuestionView.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 22/03/2022.
//
import SwiftUI
import MapKit
import Foundation
import TipKit

struct QuestionAndAnswerView: View {
    @State var question: Question
    @State private var selection = 0
    private let tip = MarkAsAnsweredTooltip()

    var body: some View {
        VStack {
            Spacer()
            ScrollView {
                if self.selection == 0 {
                    QuestionView(question: question)
                } else {
                    AnswerView(question: question)
                }
            }
            Picker("", selection: $selection) {
                Text("Question").tag(0)
                Text("See Answer").tag(1)
            }
            .pickerStyle(.segmented)
            .padding()
            .padding(.bottom, 44)
        }

        .ignoresSafeArea(edges: .bottom)
        .navigationBarTitle("# \(question.id)").foregroundColor(.mainBlack)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: HStack {
            ShareLink(item: render(question: question, withAnswer: self.selection == 1))
                .labelStyle(.iconOnly)
                .imageScale(.large)
            MarkAsAnsweredButton(questionId: question.globalId)
                .popoverTip(tip)
                .onTapGesture {
                    Task {
                        await MarkAsAnsweredTooltip.alreadyDiscoveredEvent.donate()
                    }
                }
        })
    }
}

#Preview  {
    NavigationView {
        QuestionAndAnswerView(question: mockQuestion2)
    }
}

