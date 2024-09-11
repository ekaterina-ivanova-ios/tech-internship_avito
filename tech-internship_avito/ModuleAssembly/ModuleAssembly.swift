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
        let presenter = SearchPresenter(photoSearchService: photoService)
        let view = SearchViewController(presenter: presenter)
        
        presenter.view = view
        
        return view
    }
}

