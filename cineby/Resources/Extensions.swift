//
//  Extensions.swift
//  cineby
//
//  Created by Rishav chandra on 16/04/25.
//

import UIKit


extension String {
    
    func captilizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}

extension UIImageView {
    func loadImage(urlString: String) {
        if let cachedImage = ImageCache.shared.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data , _ , error in
            guard let self = self ,let data = data , let image = UIImage(data: data), error == nil else {return}
            ImageCache.shared.setObject(image, forKey: urlString as NSString)
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}


class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
}
