//
//  AreaImageLoader.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 01/12/2024.
//

import SwiftUI
import Combine
import Observation

@Observable class ImageLoader {
    var images: [URL: UIImage] = [:]

    private var cancellables: [URL: AnyCancellable] = [:]

    func loadImage(from url: URL) {
        // Check if image is in the cache
        if let cachedImage = ImageCache.shared.image(for: url) {
            self.images[url] = cachedImage
            return
        }

        // Create request with timeout to prevent hanging
        var request = URLRequest(url: url)
        request.timeoutInterval = 30
        request.cachePolicy = .returnCacheDataElseLoad

        // Download with timeout protection
        cancellables[url] = URLSession.shared.dataTaskPublisher(for: request)
            .timeout(.seconds(30), scheduler: DispatchQueue.global())
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] downloadedImage in
                if let downloadedImage = downloadedImage {
                    ImageCache.shared.setImage(downloadedImage, for: url)
                }
                self?.images[url] = downloadedImage
            }
    }

    func cancel(for url: URL?) {
        if let url {
            cancellables[url]?.cancel()
            cancellables[url] = nil
        }
    }
}

//class MockImageLoader: ImageLoader {
//    override func loadImage(from url: URL) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
//            self?.images[url] = UIImage(systemName: "crouchEnd")
//        }
//    }
//}
