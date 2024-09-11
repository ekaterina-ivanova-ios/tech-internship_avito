//
//  SearchPresenter.swift
//  tech-internship_avito
//
//  Created by Екатерина Иванова on 09.09.2024.
//

import Foundation

final class SearchPresenter {
    
    weak var view: SearchViewController?
    
    private let photoSearchService: PhotoSearchServiceProtocol
    
    // тут должен быть сторадж
    var searchHistory = ["Previous1", "Example", "Another search", "History", "Content"]
    var filteredSuggestions = [String]()
    var cellModels = [MediaContent]()
    
    init(photoSearchService: PhotoSearchServiceProtocol) {
        self.photoSearchService = photoSearchService
    }
    
    private func searchPhotos(_ searchText: String) {
        photoSearchService.searchPhotos(parameters: [.query(searchText)]) { [weak self] result in
            guard let self else {
                return
            }
            switch result {
            case .success(let response):
                // отображаем коллекцию
                cellModels = response.results.compactMap {
                    guard let description = $0.description else {
                        return nil
                    }
                    
                    guard let url = URL(string: $0.urls.small) else {
                        return nil
                    }
                    return MediaContent(title: "",
                                        description: description,
                                        author: $0.user.name,
                                        imageUrl: url,
                                        id: $0.id)
                }
                view?.updateCollection()

            case .failure(let error):
                // отображаем ошибку
                break
            }
        }
    }
}

extension SearchPresenter: SearchPresenterProtocol {

    func viewDidLoad() {
        
    }
    
    func textDidChange(_ searchText: String) {
        filteredSuggestions = searchHistory.filter { $0.lowercased().contains(searchText.lowercased()) }
    }
    
    func searchButtonClicked(_ searchText: String) {
        searchPhotos(searchText)
    }
    
}


