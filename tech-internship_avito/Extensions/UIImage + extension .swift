//
//  UIImage + extension .swift
//  tech-internship_avito
//
//  Created by Екатерина Иванова on 12.09.2024.
//

import UIKit

extension UIImage {
    
    func saveImageToPhotosAlbum() {
        UIImageWriteToSavedPhotosAlbum(self, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Error saving image: \(error.localizedDescription)")
        } else {
            print("Image saved to Photos")
        }
    }
    
}
