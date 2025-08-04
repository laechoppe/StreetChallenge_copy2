//
//  AnswerView.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 16/06/2024.
//

import SwiftUI

struct AnswerView: View {
    @Environment(ImageLoader.self) var imageLoader: ImageLoader
    @State private var showingImagePopover = false
    @State private var showingMapPopover = false
    let question: Question
    var upperSectionShown: Bool {
        (question.answerImageUrl != nil) || (question.answerCoordinate != nil)
    }
    private let imageDimensions: CGFloat = 200

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if let url = question.answerImageUrl {
                    if let image = imageLoader.images[url] {
                        GeometryReader { geometry in
                            ResizableImageView(image: image)
                                .frame(
                                    width: geometry.size.width,
                                    height: imageDimensions
                                )
                                .cornerRadius(8)
                                .onTapGesture {
                                    showingImagePopover = true
                                }
                                .fullScreenCover(isPresented: $showingImagePopover) {
                                    QuestionImageWrapperView(image: image, title: question.answerText)
                                }
                        }
                    } else {
                        ProgressView()
                    }
                }
                if let answerCoordinate = question.answerCoordinate {
                    MiniMapView(
                        answerCoordinate: MapCentrePoint(centre: answerCoordinate),
                        title: question.answerText,
                        isPresented: $showingMapPopover
                    )
                    .cornerRadius(8)
                }
            }
            .frame(
                height: upperSectionShown ? imageDimensions : 0,
                alignment: .center
            )
            Text(question.answerText)
                .padding(.init([.top, .bottom]))
            Text(question.commentText)
                .italic()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .onAppear {
            if let url = question.answerImageUrl {
                imageLoader.loadImage(from: url)
            }
        }
    }
}

#Preview {
    AnswerView(question: mockQuestion5)
        .environment(ImageLoader())
}
