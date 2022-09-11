//
//  ImageCache.swift
//  Group4_MoviesApp
//
//  Created by user206032 on 9/11/22.
//

import UIKit

protocol ImageCache {
    subscript(_url:URL) -> UIImage? {get set}
}

struct TempImageCahce: ImageCache {
    
    
    private let cache: NSCache<NSURL, UIImage> = {
        let cache = NSCache<NSURL, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024*1024*100
        return cache
    }()
    
    subscript(_ url: URL) -> UIImage? {
        get {
            cache.object(forKey: url as NSURL)
        }
        set {
            newValue == nil ? cache.removeObject(forKey: url as NSURL) :
                cache.setObject(newValue!, forKey: url as NSURL)
        }
    }
}
