//
//  DetailViewPresenterProtocol.swift
//  tech-internship_avito
//
//  Created by Екатерина Иванова on 09.09.2024.
//

import Foundation

protocol DetailViewPresenterProtocol: AnyObject {
    var view: DetailViewControllerProtocol? {get set}
    var detailModel: PhotoCollectionCellModel? {get set}
    func fetchData()
    
    
}
