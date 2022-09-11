//
//  ImagesLoade.swift
//  Group4_MoviesApp
//
//  Created by user206032 on 9/11/22.
//

import Combine
import UIKit

final class ImagesLoader: ObservableObject{
    @Published var image: UIImage?
    
    private(set) var isLoading = false
    private let url: URL
    private var cache:  ImageCache?
    private var cancellabel: AnyCancellable?
    private let ImageProccQueue = DispatchQueue(label: "image-processing")
    
    init(url: URL, cache: ImageCache? = nil) {
        self.url = url
        self.cache = cache
    }
    
    deinit {
        cancel()
    }
    
    func cancel(){
        cancellabel?.cancel()
    }
    
    func load(){
        guard !isLoading else {
            return
        }
        if let image = cache?[url]{
            self.image = image
            return
        }
        cancellabel = URLSession.shared.dataTaskPublisher(for: url).map{UIImage(data: $0.data)}.replaceError(with: nil)
            .handleEvents(
                receiveSubscription: {[weak self] _ in self?.onStart()},
                receiveOutput: {[weak self] in self?.cache($0)},
                receiveCompletion: {[weak self] _ in self?.onFinish()},
                receiveCancel: {[weak self] in self?.onFinish()}
            )
            .subscribe(on: self.ImageProccQueue)
            .receive(on: DispatchQueue.main)
            .sink{[weak self] in self?.image = $0}
    }
    private func onStart(){
        isLoading = true
    }
    private func onFinish(){
        isLoading = false
    }
    
    private func cache(_ image: UIImage?){
        image.map{cache?[url] = $0}
    }
}


