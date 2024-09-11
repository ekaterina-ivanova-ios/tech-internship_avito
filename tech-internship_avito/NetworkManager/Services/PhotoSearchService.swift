//
//  PhotoSearchService.swift
//  tech-internship_avito
//
//  Created by Екатерина Иванова on 11.09.2024.
//
import Foundation

enum PhotoSearchParameter {
    case query(_ query: String)
}

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
                URLQueryItem(name: "query", value: query)
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

import Foundation

// Главная структура ответа на поиск
struct SearchResponse: Codable {
    let total: Int
    let totalPages: Int
    let results: [Photo]

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

// Структура для фотографии
struct Photo: Codable {
    let id: String
    let createdAt: String
    let width: Int
    let height: Int
    let color: String
    let blurHash: String?
    let likes: Int
    let likedByUser: Bool
    let description: String?
    let user: User
    let currentUserCollections: [UserCollection]
    let urls: Urls
    let links: PhotoLinks

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case width
        case height
        case color
        case blurHash = "blur_hash"
        case likes
        case likedByUser = "liked_by_user"
        case description
        case user
        case currentUserCollections = "current_user_collections"
        case urls
        case links
    }
}

// Структура для пользователя
struct User: Codable {
    let id: String
    let username: String
    let name: String
    let firstName: String
    let lastName: String?
    let instagramUsername: String?
    let twitterUsername: String?
    let portfolioURL: String?
    let profileImage: ProfileImage
    let links: UserLinks

    enum CodingKeys: String, CodingKey {
        case id
        case username
        case name
        case firstName = "first_name"
        case lastName = "last_name"
        case instagramUsername = "instagram_username"
        case twitterUsername = "twitter_username"
        case portfolioURL = "portfolio_url"
        case profileImage = "profile_image"
        case links
    }
}

// Структура для изображений профиля пользователя
struct ProfileImage: Codable {
    let small: String
    let medium: String
    let large: String
}

// Структура для ссылок пользователя
struct UserLinks: Codable {
    let selfLink: String
    let html: String
    let photos: String
    let likes: String

    enum CodingKeys: String, CodingKey {
        case selfLink = "self"
        case html
        case photos
        case likes
    }
}

// Структура для коллекций пользователя
struct UserCollection: Codable {
    // Добавьте поля, если они присутствуют в данных
}

// Структура для URL-адресов фотографии
struct Urls: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}

// Структура для ссылок фотографии
struct PhotoLinks: Codable {
    let selfLink: String
    let html: String
    let download: String

    enum CodingKeys: String, CodingKey {
        case selfLink = "self"
        case html
        case download
    }
}

