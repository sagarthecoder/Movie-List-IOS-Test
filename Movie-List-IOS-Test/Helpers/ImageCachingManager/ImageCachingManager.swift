//
//  ImageCachingManager.swift
//  Movie-List-IOS-Test
//
//  Created by Sagar on 2/23/24.
//

import UIKit

class ImageCachingManager {
    
    let cache = NSCache<NSURL, UIImage>()
    
    init() {
        setCacheLimit()
    }
    
    func setCacheLimit(mb : Int = 60) {
        cache.totalCostLimit = 1_000_000 * mb
    }
    
    func cacheImage(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url as NSURL)
    }

    func image(for url: URL) -> UIImage? {
        guard let image = cache.object(forKey: url as NSURL) else {
            return nil
        }
        return image
    }

}
