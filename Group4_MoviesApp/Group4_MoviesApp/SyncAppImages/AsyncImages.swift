//
//  AsyncImages.swift
//  Group4_MoviesApp
//
//  Created by user206032 on 9/14/22.
//

import SwiftUI

struct AsyncImages<Placeholder: View>: View {
    @StateObject private var loader: ImagesLoader
    private let placeholder: Placeholder
    private let image: (UIImage) -> Image
init(
    url: URL,
    @ViewBuilder placeholder: () -> Placeholder,
    @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)
) {
    self.placeholder = placeholder()
    self.image = image
    _loader = StateObject(wrappedValue: ImagesLoader(url: url, cache: Environment(\.imageCache).wrappedValue))
    
}
    
    var body: some View {
        content.onAppear(perform: loader.load)
    }
private var content: some View {
    Group {
        if loader.image != nil {
image(loader.image!) } else {
placeholder
}
    }
}
}

