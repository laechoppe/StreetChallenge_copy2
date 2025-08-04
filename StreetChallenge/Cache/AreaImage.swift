//
//  AreaImage.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 01/12/2024.
//

import SwiftUI
import Combine

final class ImageCache: @unchecked Sendable {
    static let shared = ImageCache()
    private init() {}

    private let cache = NSCache<NSURL, UIImage>()

    func image(for url: URL) -> UIImage? {
        return cache.object(forKey: url as NSURL)
    }

    func setImage(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url as NSURL)
    }
}
