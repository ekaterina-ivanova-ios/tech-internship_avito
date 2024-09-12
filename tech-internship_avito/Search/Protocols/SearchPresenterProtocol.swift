//
//  SearchPresenterProtocol.swift
//  tech-internship_avito
//
//  Created by Екатерина Иванова on 09.09.2024.
//

import Foundation

protocol SearchPresenterProtocol: AnyObject {
    
    var filteredSuggestions: [String] { get }
    var cellModels: [PhotoCollectionCellModel] { get }
    
    func textDidChange(_ searchText: String)
    func searchButtonClicked(_ searchText: String)
    func didSelectTip(at indexPath: IndexPath)
}
