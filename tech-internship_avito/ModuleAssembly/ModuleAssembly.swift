//
//  ModuleAssembly.swift
//  tech-internship_avito
//
//  Created by Екатерина Иванова on 11.09.2024.
//

import UIKit

struct ModuleAssembly {
    
    static func makeSearchModule() -> UIViewController {
        let photoService = DIContainer.shared.getPhotoService()
        let searchHistoryStorage = DIContainer.shared.getSearchHistoryStorage()
        let presenter = SearchPresenter(
            photoSearchService: photoService,
            searchHistoryStorage: searchHistoryStorage
        )
        let view = SearchViewController(presenter: presenter)
        
        presenter.view = view
        
        return view
    }
    
    static func makeDetailModule(_ detailModel: PhotoCollectionCellModel) -> UIViewController {
        let presenter = DetailViewPresenter(
          detailModel: detailModel
        )
        let view = DetailViewController(presenter: presenter)
        
        presenter.view = view
        
        return view
    }
}

