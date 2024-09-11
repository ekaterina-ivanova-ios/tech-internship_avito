//
//  SearchViewControllerProtocol.swift
//  tech-internship_avito
//
//  Created by Екатерина Иванова on 09.09.2024.
//

import Foundation

protocol SearchViewControllerProtocol: AnyObject {
    func updateCollection()
    func updateTipsTableView()
    func updateSearchBarText(_ text: String)
    func updateState(_ state: SearchState)
}
