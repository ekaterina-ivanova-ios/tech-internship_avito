//
//  SearchViewPresenter.swift
//  tech-internship_avito
//
//  Created by Екатерина Иванова on 09.09.2024.
//

import Foundation

final class SearchViewPresenter {
    
    private let networkManager: NetworkClient
    weak var view: SearchViewController?
    
    init(networkManager: NetworkClient) {
        self.networkManager = networkManager
    }
    
    func viewDidLoad() {
        networkManager.send(request: SearchCollectionGetRequest(), type: SearchCollectionResponse.self) { result in
            switch result {
            case .success(let response): break
            case .failure(let error): break
            }
        }
    }
    
}


//перенести в другой файл
struct SearchCollectionResponse: Decodable {
    let results: [SearchCollectionResultResponse]
}

struct SearchCollectionResultResponse: Decodable {
    let coverPhoto: CoverPhotosResponse
    
    private enum CodingKeys: String, CodingKey {
        case coverPhoto = "cover_photo"
        }
}

struct CoverPhotosResponse: Decodable {
    
}


