//
//  SearchResponseModel.swift
//  tech-internship_avito
//
//  Created by Екатерина Иванова on 12.09.2024.
//

import Foundation

struct SearchResponse: Codable {
    let results: [Photo]
}

// Структура для фотографии
struct Photo: Codable {
    let description: String?
    let user: User
    let urls: Urls
    let id: String
}

// Структура для пользователя
struct User: Codable {
    let name: String
}

// Структура для URL-адресов фотографии
struct Urls: Codable {
    let small: String
}



