//
//  DIContainer.swift
//  tech-internship_avito
//
//  Created by Екатерина Иванова on 11.09.2024.
//

import Foundation

final class DIContainer {
    
    // Storages
    
    private var searchHistoryStorage: SearchHistoryStorageProtocol?
    
    
    // Managers
    
    private var networkManager: NetworkManager?
    
    // Singleton

    static let shared = DIContainer()
    
    private init() { }

    func getNetworkManager() -> NetworkClient {
        if let networkManager {
            return networkManager
        } else {
            let newManager = NetworkManager()
            self.networkManager = newManager
            return newManager
        }
    }
    
    func getSearchHistoryStorage() -> SearchHistoryStorageProtocol {
        if let searchHistoryStorage {
            return searchHistoryStorage
        } else {
            let searchHistoryStorage = SearchHistoryStorage()
            self.searchHistoryStorage = searchHistoryStorage
            return searchHistoryStorage
        }
    }
    
    func getPhotoService() -> PhotoSearchServiceProtocol {
        PhotoSearchService(networkManager: getNetworkManager())
    }
}
