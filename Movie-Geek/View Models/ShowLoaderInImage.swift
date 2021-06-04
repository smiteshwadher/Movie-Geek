//
//  ShowLoaderInImage.swift
//  Movie-Geek
//
//  Created by Smitesh Wadher on 03/06/21.
//

import SwiftUI
import UIKit

private let _imageCache = NSCache<AnyObject, AnyObject>()

// this is to show a loader while loading the image from the posterURL for the particular movie clicked or in the movie listing page.
class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?
    @Published var isLoading = false
    
    var imageCache = _imageCache

    func loadImage(with url: URL) {
        let urlString = url.absoluteString
        
        // Implemented default cache so as to avoid the memory consumption / network consumption and load image faster the next time the app is opened.
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else {
                    return
                }
                
                // Once the image is fetched above the from the URL, it is then stored in the cache.
                self.imageCache.setObject(image, forKey: urlString as AnyObject)
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

