//
//  PhotoSearchParameter.swift
//  tech-internship_avito
//
//  Created by Екатерина Иванова on 12.09.2024.
//

import Foundation

enum PhotoSearchParameter {
    case query(_ query: String)
    case perPage(_ count: Int)
}
