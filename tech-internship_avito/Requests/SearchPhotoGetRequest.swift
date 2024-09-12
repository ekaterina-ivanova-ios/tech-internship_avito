//
//  SearchPhotoGetRequest.swift
//  tech-internship_avito
//
//  Created by Екатерина Иванова on 11.09.2024.
//

import Foundation

struct SearchPhotoGetRequest: NetworkRequest {
    
    var endpoint: String {
        NetworkConstant.baseUrl + "/search/photos"
    }
    
    var httpMethod: HttpMethod {
        .get
    }

    let queryItems: [URLQueryItem]
}
