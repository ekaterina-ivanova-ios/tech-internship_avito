//
//  DetailViewDelegate.swift
//  tech-internship_avito
//
//  Created by Екатерина Иванова on 09.09.2024.
//

import Foundation
import UIKit

protocol DetailViewDelegate: AnyObject {
    func didTapShareButton(image: UIImage)
    func didTapDownloadButton(image: UIImage)
}
