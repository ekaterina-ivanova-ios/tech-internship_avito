//
//  DetailViewPresenter.swift
//  tech-internship_avito
//
//  Created by Екатерина Иванова on 09.09.2024.
//

import Foundation

final class DetailViewPresenter: DetailViewPresenterProtocol {
   
    weak var view: DetailViewControllerProtocol?
    
    private let detailModel: PhotoCollectionCellModel
    
    init(detailModel: PhotoCollectionCellModel) {
        self.detailModel = detailModel
    }
    
    func viewDidLoad() {
        view?.update(with: detailModel)
    }

    
}


