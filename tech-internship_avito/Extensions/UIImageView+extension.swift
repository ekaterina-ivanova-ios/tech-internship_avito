//
//  UIImageView+extension.swift
//  tech-internship_avito
//
//  Created by Екатерина Иванова on 11.09.2024.
//

import UIKit

extension UIImageView {
    
    func downloadImage(from url: URL) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                ImageCacheManager.shared.setObject(image, forKey: url.absoluteString as NSString)
                
                DispatchQueue.main.async {
                    self.image = image
                }
            }
            // здесь нужно обработать ошибку загрузки изображения
        }
        task.resume()
    }
}
