//
//  TileImageView.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 28/03/2022.
//

import SwiftUI

struct TileImageView: View {
    var url: URL?
    var size: CGSize
    @Environment(ImageLoader.self) var imageLoader: ImageLoader

    var body: some View {
        Group {
            if let url, let image = imageLoader.images[url] {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width * 0.7, height: size.height * 0.7)
                    .clipped()
                    .cornerRadius(30)
            } else {
                ProgressView()
                   .frame(width: size.width * 0.7, height: size.height * 0.7)
            }
        }
        .onAppear {
            if let url {
                imageLoader.loadImage(from: url)
            }
        }
    }
}

struct TileImageView_Previews: PreviewProvider {
    static var previews: some View {
        let url = URL(string: "https://fastly.picsum.photos/id/994/200/300.jpg?hmac=qE64z1oNNOrx-yilgjIyDxWRQ7WIawmgrfrHGY-0aGs")
        TileImageView(url: url, size: CGSize())
            .environment(ImageLoader())
    }
}
