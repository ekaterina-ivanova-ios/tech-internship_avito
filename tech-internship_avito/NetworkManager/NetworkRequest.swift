//
//  NetworkRequest.swift
//  tech-internship_avito
//
//  Created by Екатерина Иванова on 09.09.2024.
//

import Foundation

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol NetworkRequest {
    var endpoint: String { get }
    var httpMethod: HttpMethod { get }
    var queryItems: [URLQueryItem] { get }
}
