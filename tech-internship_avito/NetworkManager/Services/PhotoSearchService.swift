//
//  PhotoSearchService.swift
//  tech-internship_avito
//
//  Created by Екатерина Иванова on 11.09.2024.
//
import Foundation

/// Сервис для выполнения поиска фотографий
protocol PhotoSearchServiceProtocol {
    func searchPhotos(
        parameters: [PhotoSearchParameter],
        completion: @escaping (Result<SearchResponse, Error>) -> Void
    )
}

final class PhotoSearchService: PhotoSearchServiceProtocol {
    
    private let networkManager: NetworkClient
    
    init(networkManager: NetworkClient) {
        self.networkManager = networkManager
    }
    
    func searchPhotos(
        parameters: [PhotoSearchParameter],
        completion: @escaping (Result<SearchResponse, Error>) -> Void
    ) {
        
        let queryItems = parameters.map {
            switch $0 {
            case .query(let query):
                URLQueryItem(name: Constant.SearchPhotos.query, value: query)
            case .perPage(let count):
                URLQueryItem(name: Constant.SearchPhotos.perPage, value: "\(count)")
            }
        }
        
        let request = SearchPhotoGetRequest(queryItems: queryItems)
        networkManager.send(
            request: request,
            type: SearchResponse.self) { result in
                DispatchQueue.main.async {
                    completion(result)
                }
            }
    }
}
