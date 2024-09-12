//
//  SearchHistoryStorage.swift
//  tech-internship_avito
//
//  Created by Екатерина Иванова on 11.09.2024.
//

import Foundation

protocol SearchHistoryStorageProtocol {
    func getHistory() -> [String]
    func saveHistory(newSearch: String)
}

final class SearchHistoryStorage {
    
    private let defaults = UserDefaults.standard
    private let historyKey = "searchHistoryKey"
    private let maxHistoryCount = 5
    
}

extension SearchHistoryStorage: SearchHistoryStorageProtocol {
    
    func getHistory() -> [String] {
        defaults.stringArray(forKey: historyKey) ?? []
    }
    
    func saveHistory(newSearch: String) {
        var currentHistory = getHistory()
        
        // Удаляем запрос, если он уже есть в списке, чтобы избежать дубликатов
        if let index = currentHistory.firstIndex(of: newSearch) {
            currentHistory.remove(at: index)
        }
        
        // Добавляем новый запрос в начало
        currentHistory.insert(newSearch, at: 0)
        
        // Ограничиваем историю до maxHistoryCount
        if currentHistory.count > maxHistoryCount {
            currentHistory = Array(currentHistory.prefix(maxHistoryCount))
        }
        
        // Сохраняем обновлённую историю
        defaults.set(currentHistory, forKey: historyKey)
    }
}
