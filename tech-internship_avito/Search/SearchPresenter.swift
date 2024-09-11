//
//  SearchPresenter.swift
//  tech-internship_avito
//
//  Created by Екатерина Иванова on 09.09.2024.
//

import Foundation

enum SearchState {
    case loading
    case error(viewModel: ErrorViewModel)
    case `default`
}

final class SearchPresenter {
    
    weak var view: SearchViewControllerProtocol?
    
    private let photoSearchService: PhotoSearchServiceProtocol
    private let searchHistoryStorage: SearchHistoryStorageProtocol
    
    private(set) var filteredSuggestions = [String]()
    private(set) var cellModels = [PhotoCollectionCellModel]()
    private var isLoading = false {
        didSet {
            view?.updateState(.loading)
        }
    }
    
    init(photoSearchService: PhotoSearchServiceProtocol,
         searchHistoryStorage: SearchHistoryStorageProtocol) {
        self.photoSearchService = photoSearchService
        self.searchHistoryStorage = searchHistoryStorage
    }
    
    private func searchPhotos(_ searchText: String) {
        
        guard !isLoading else {
            return
        }
        isLoading = true
        photoSearchService.searchPhotos(parameters: [.query(searchText), .perPage(30)]) { [weak self] result in
            guard let self else {
                return
            }
            isLoading = false
            switch result {
            case .success(let response):
                handleDidGet(photos: response.results)
            case .failure(let error):
                handleDidGet(error: error, searchText: searchText)
            }
        }
    }
    
    private func handleDidGet(error: Error, searchText: String) {
        print("Did get error: ", error)
        let model = ErrorViewModel(
            errorMessage: "Не удалось загрузить контент. Пожалуйста, попробуйте еще раз"
        ) { [weak self] in
            self?.searchPhotos(searchText)
        }
        view?.updateState(.error(viewModel: model))
    }
    
    private func handleDidGet(photos: [Photo]) {
        cellModels = photos.compactMap {
            guard let description = $0.description,
                  !description.isEmpty else {
                return nil
            }
            
            guard let url = URL(string: $0.urls.small) else {
                return nil
            }
            return PhotoCollectionCellModel(description: description,
                                            author: $0.user.name,
                                            imageUrl: url,
                                            id: $0.id)
        }
        view?.updateCollection()
        view?.updateState(.default)
    }
}

extension SearchPresenter: SearchPresenterProtocol {
    
    func viewDidLoad() {
        
    }
    
    func textDidChange(_ searchText: String) {
        let history = searchHistoryStorage.getHistory()
        filteredSuggestions = history.filter { $0.lowercased().contains(searchText.lowercased()) }
        view?.updateTipsTableView()
    }
    
    func searchButtonClicked(_ searchText: String) {
        searchPhotos(searchText)
        searchHistoryStorage.saveHistory(newSearch: searchText)
    }
    
    func didSelectTip(at indexPath: IndexPath) {
        let searchText = filteredSuggestions[indexPath.row]
        searchPhotos(searchText)
        searchHistoryStorage.saveHistory(newSearch: searchText)
        view?.updateSearchBarText(searchText)
    }
    
}


