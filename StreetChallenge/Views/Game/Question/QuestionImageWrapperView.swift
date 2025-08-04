//
//  QuestionImageViewWrapper.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 10/06/2022.
//

import SwiftUI

struct QuestionImageWrapperView: View {
    var image: UIImage
    var title: String
    
    var body: some View {
        VStack {
            QuestionImageView(image: image)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topTrailing){
            NavBarCloseButton(title: title)
        }
        
    }
}

struct QuestionImageWrapperView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionImageWrapperView(
            image: UIImage(imageLiteralResourceName: "image1"),
            title: "Queen Victoria"
        )
    }
}
