//
//  DetailViewControllerProtocol.swift
//  tech-internship_avito
//
//  Created by Екатерина Иванова on 09.09.2024.
//

import Foundation

protocol DetailViewControllerProtocol: AnyObject {
    var presenter: DetailViewPresenterProtocol? { get set }
    func reloadCollectionView()
    func showErrorAlert()
}
