//
//  EnvirnomentCache.swift
//  Group4_MoviesApp
//
//  Created by user206032 on 9/14/22.
//

import SwiftUI
struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = TempImageCahce()
    
}
extension EnvironmentValues {
        var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}
