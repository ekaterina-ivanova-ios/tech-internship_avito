//
//  DetailViewControllerProtocol.swift
//  tech-internship_avito
//
//  Created by Екатерина Иванова on 09.09.2024.
//

import Foundation

protocol DetailViewControllerProtocol: AnyObject {
    func reloadCollectionView()
    func showErrorAlert()
    func update(with model: PhotoCollectionCellModel)
}
