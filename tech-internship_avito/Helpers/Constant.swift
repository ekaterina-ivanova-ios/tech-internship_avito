//
//  Constant.swift
//  tech-internship_avito
//
//  Created by Екатерина Иванова on 12.09.2024.
//

import Foundation
import UIKit

enum Constant {
    
    enum ButtonImage {
        static let listButton = UIImage(systemName: "list.bullet")
        static let panelButton = UIImage(systemName: "square.grid.2x2")
        static let shareButton = UIImage(systemName: "square.and.arrow.up")
        static let downloadButton = UIImage(systemName: "arrow.down.circle")
    }
    
    enum Title {
        static let titleNavBar = "Crazy searcher"
        static let titleSearchBar = "Enters a search term..."
    }
    
    enum CellId {
        static let cellId = "SuggestionCell"
    }
    
    enum AlertTetx {
        static let errorText = "Did get error: "
        static let reloadPageText = "Failed. Please try to reload page"
    }
    
    enum SearchPhotos {
        static let query = "query"
        static let perPage = "per_page"
        static let perPageCount = 30
    }
}
