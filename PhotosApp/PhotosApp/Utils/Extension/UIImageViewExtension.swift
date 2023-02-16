//
//  UIImageViewExtension.swift
//  PhotosApp
//
//  Created by Rajeswaran Thangaperumal on 16/02/23.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func load(url: URL) {
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            
            self.image = imageFromCache
            
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                  
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                    imageCache.setObject(image, forKey: url as AnyObject)
                }
            }
        }
    }
    
    func load(urlString:String) {
        guard let url = URL(string: urlString) else { return  }
        self.load(url: url)
    }
}
