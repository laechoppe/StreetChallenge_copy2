//
//  PdfCreator.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 07/06/2022.
//

import Foundation
import SwiftUI

@MainActor
func render(question: Question, withAnswer: Bool) -> URL {
    // 1: Render Hello World with some modifiers
    let name: String = "\(question.areaName) - Question \(question.id)"
    let renderer = ImageRenderer(
        content:
            VStack(alignment: .leading, spacing: 20) {
                Text(name)
                    .font(.title)
                Text(question.questionText)
                Spacer()
                if withAnswer {
                    Text("Answer")
                        .font(.title)
                    Text(question.answerText)
                    Text(question.commentText)
                        .italic()
                }
                Spacer()
            }
            .padding()
    )

    // 2: Save it to our documents directory
    
    let url = URL.documentsDirectory.appending(path: "\(name).pdf")

    // 3: Start the rendering process
    renderer.render { size, context in
        // 4: Tell SwiftUI our PDF should be the same size as the views we're rendering
        var box = CGRect(x: 0, y: 0, width: size.width, height: size.height)

        // 5: Create the CGContext for our PDF pages
        guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil) else {
            return
        }

        // 6: Start a new PDF page
        pdf.beginPDFPage(nil)

        // 7: Render the SwiftUI view data onto the page
        context(pdf)

        // 8: End the page and close the file
        pdf.endPDFPage()
        pdf.closePDF()
    }

    return url
}

struct pdfView: View {
    let question: Question = mockQuestion

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("\(question.areaName): Question \(question.id)")
                .font(.title)
            Text(question.questionText)
            Spacer()
            Text("Answer")
                .font(.title)
            Text(question.answerText)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    pdfView()
}
