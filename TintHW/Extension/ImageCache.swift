//
//  ImageCache.swift
//  TintHW
//
//  Created by Ting on 2024/4/3.
//

import Foundation
import UIKit

// Image Cache
class ImageCache {
    
    static let shared = ImageCache()
    private var cache = NSCache<NSString, UIImage>()
    
    func image(for key: String) -> UIImage? {
        return cache.object(forKey: NSString(string: key))
    }
    
    func save(_ image: UIImage, for key: String) {
        cache.setObject(image, forKey: NSString(string: key))
    }
}
