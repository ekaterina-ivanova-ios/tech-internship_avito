//
//  NetworkRequest.swift
//  tech-internship_avito
//
//  Created by Екатерина Иванова on 09.09.2024.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol NetworkRequest {
    var endpoint: URL? { get }
    var httpMethod: HttpMethod { get }
}

extension NetworkRequest {
    var httpMethod: HttpMethod { .get }
    var dto: Encodable? { nil }
}


struct SearchCollectionGetRequest: NetworkRequest {
    var endpoint: URL? {
        //URL(string: Resourses.Network.baseURL + Resourses.Network.Paths.profile)
        URL(string: "https://api.unsplash.com/search/collections")
    }
    var httpMethod: HttpMethod { .get }
}

