//
//  CloseNavBarButton.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 30/12/2023.
//

import SwiftUI

struct NavBarCloseButton: View {
    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>
    let title: String

    init(title: String) {
        self.title = title
    }

    var body: some View {
        HStack {
            ZStack{
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .padding()
                    })
                    Spacer()
                }
                Text(title)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .fontWeight(.bold)
            }
        }
    }
}

struct MapCloseButton_Previews: PreviewProvider {
    static var previews: some View {
        NavBarCloseButton(title: "Area")
    }
}
