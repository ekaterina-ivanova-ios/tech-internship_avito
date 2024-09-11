//
//  DIContainer.swift
//  tech-internship_avito
//
//  Created by Екатерина Иванова on 11.09.2024.
//

import Foundation

final class DIContainer {
    
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
    
    func getPhotoService() -> PhotoSearchServiceProtocol {
        PhotoSearchService(networkManager: getNetworkManager())
    }
}
