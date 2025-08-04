//
//  QuestionsListView.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 22/03/2022.
//

import SwiftUI
import Firebase

struct QuestionsListView: View {
    @Environment(QuestionsViewModel.self) private var questionsViewModel: QuestionsViewModel
    var area: Area
    @State private var showingMapPopover = false
    @State private var showingFaqPopover = false
    @State private var selectedQuestion: Question?
    @State private var isShowingDetailView = false
    @Binding var paywallPresented: Bool
    @Environment(UserViewModel.self) private var userModel: UserViewModel

    var body: some View {
        VStack {
            ScrollView {
                    VStack {
                        if !questionsViewModel.questions.isEmpty {
                            let filteredQuestions = questionsViewModel.questions.filter( { $0.areaId == area.id } )
                            LazyVGrid(
                                columns: [
                                    GridItem(.adaptive(minimum: 100))
                                ],
                                content: {
                                    ForEach(filteredQuestions, id: \.globalId) { item in
                                        Button(action: {
                                            selectedQuestion = item
                                            isShowingDetailView = true
                                        }) {
                                            QuestionItemView(
                                                question: item,
                                                area: area,
                                                selectedQuestion: $selectedQuestion,
                                                isShowingDetailView: $isShowingDetailView
                                            )
                                            .frame(maxWidth: .infinity)
                                        }
                                    }
                                }
                            )
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.horizontal, 16)
                            Spacer()
                        } else {
                            VStack{
                                Spacer()
                                tapToReloadButton
                                Spacer()
                            }
                        }
                    }
                    .navigationDestination(isPresented: $isShowingDetailView) {
                        if let question = selectedQuestion {
                            QuestionAndAnswerView(question: question)
                        } else {
                            Text("Please try again later")
                        }
                    }
            }
        }
        .navigationBarTitle(area.name)
        .foregroundColor(.mainBlack)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: HStack {
            AreaInfoNavBarButton(isPresented: $showingMapPopover, area: area)
            Button(action: {
                self.showingFaqPopover.toggle()
            }, label: {
                Image(systemName: "questionmark.circle")
                    .foregroundColor(.mainBlack)
                    .font(.body)
            })
            .sheet(isPresented: $showingFaqPopover) {
                AreaFaqView(area: area)
            }
        })
        .onAppear() {
            if area.premium {
                checkSubscription()
            }
        }
    }
    
    var tapToReloadButton: some View {
        Button(action: {
            Task {
                do {
                    await questionsViewModel.fetchData()
                }
            }
        }, label: {
            VStack {
                Image(systemName: "arrow.clockwise")
                    .foregroundColor(.mainBlack)
                    .font(.title2)
                    .padding(0.1)
                Text("Tap to reload")
                    .font(.title3)
            }
            .shadow(radius: 1.0)
            
        })
    }
    
    var resetAnsweredQuestionsButton: some View {
        Button(action: {
            questionsViewModel.resetAnswers(questionsGlobalIds: questionsViewModel.questions.map { $0.globalId })
        }, label: {
            HStack {
                Image(systemName: "eraser.line.dashed.fill")
                    .font(.title3)
                    .padding(0.1)
                Text("Reset answers")
            }
            .shadow(radius: 1.0)
            .foregroundColor(.gray)
        })
    }

    private func checkSubscription() {
        if !self.userModel.subscriptionActive {
            self.paywallPresented.toggle()
        }
    }
}

struct QuestionsListView_Previews: PreviewProvider {
    static let questionsViewModel: QuestionsViewModel = {
        let viewModel = QuestionsViewModel()
        viewModel.questions = [mockQuestion, mockQuestion2, mockQuestion3, mockQuestion4]
        return viewModel
    }()

    static var previews: some View {
        NavigationStack {
            QuestionsListView(
                area: mockArea,
                paywallPresented: .constant(false)
            )
            .environment(questionsViewModel)
        }
    }
}
