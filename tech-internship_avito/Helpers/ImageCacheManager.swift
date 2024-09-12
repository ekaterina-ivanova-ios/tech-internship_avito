//
//  ImageCacheManager.swift
//  tech-internship_avito
//
//  Created by Екатерина Иванова on 11.09.2024.
//

import UIKit

final class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
}
