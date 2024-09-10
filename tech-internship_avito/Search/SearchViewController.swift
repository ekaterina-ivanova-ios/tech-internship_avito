//
//  ViewController.swift
//  tech-internship_avito
//
//  Created by Екатерина Иванова on 09.09.2024.
//

import UIKit

final class SearchViewController: UIViewController {
   
        private let searchBar = UISearchBar()
        private let suggestionTableView = UITableView()
        private let resultCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            layout.itemSize = CGSize(width: (UIScreen.main.bounds.width/2) - 20, height: (UIScreen.main.bounds.width/2) - 20)
            return UICollectionView(frame: .zero, collectionViewLayout: layout)
        }()

    //hardCode
    var detailModel = MediaContent(
        title: "Books",
        description: "Amazing stories Amazing stories Amazing stories Amazing stories Amazing stories Amazing stories Amazing stories Amazing stories Amazing stories Amazing stories",
        author: "author: Peter",
        imageUrl: "photo1",
        id: "1")
        private var searchHistory: [String] = []
        private var filteredSuggestions: [String] = []
        private var searchResults: [MediaContent] = []

        override func viewDidLoad() {
            super.viewDidLoad()

            setupUI()
            loadSearchHistory()
        }

        private func setupUI() {
            view.backgroundColor = .white

            // Setup searchBar
            searchBar.delegate = self
            searchBar.placeholder = "Поиск медиа контента..."
            view.addSubview(searchBar)
            searchBar.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])

            // Setup suggestionTableView
            suggestionTableView.delegate = self
            suggestionTableView.dataSource = self
            suggestionTableView.register(UITableViewCell.self, forCellReuseIdentifier: "SuggestionCell")
            view.addSubview(suggestionTableView)
            suggestionTableView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                suggestionTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
                suggestionTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                suggestionTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                suggestionTableView.heightAnchor.constraint(equalToConstant: 200)
            ])

            // Setup resultCollectionView
            resultCollectionView.delegate = self
            resultCollectionView.dataSource = self
            resultCollectionView.register(SearchViewCell.self, forCellWithReuseIdentifier: SearchViewCell.identifier)
            view.addSubview(resultCollectionView)
            resultCollectionView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                resultCollectionView.topAnchor.constraint(equalTo: suggestionTableView.bottomAnchor),
                resultCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                resultCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                resultCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }

        private func loadSearchHistory() {
            // Load history from UserDefaults or other storage
            searchHistory = ["Previous1", "Example", "Another search", "History", "Content"]
        }
    }

    extension SearchViewController: UISearchBarDelegate {
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            // Update suggestions based on input
            filteredSuggestions = searchHistory.filter { $0.lowercased().contains(searchText.lowercased()) }
            suggestionTableView.isHidden = filteredSuggestions.isEmpty
            suggestionTableView.reloadData()
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            // Perform search
            performSearch(query: searchBar.text ?? "")
            searchBar.resignFirstResponder()
        }

        private func performSearch(query: String) {
            // Save to history
            addQueryToHistory(query)
            
            // Call API to search and update `searchResults`
            
            // Reload resultCollectionView
            

            // Example reload
            searchResults = [MediaContent(title: "Books", description: "Amazing stories", author: "Peter", imageUrl: "photo", id: "1"), MediaContent(title: "Books", description: "Amazing stories", author: "Peter", imageUrl: "photo", id: "1")]
            resultCollectionView.reloadData()
        }

        private func addQueryToHistory(_ query: String) {
            guard !query.isEmpty else { return }
            if let index = searchHistory.firstIndex(of: query) {
                searchHistory.remove(at: index)
            }
            searchHistory.insert(query, at: 0)
            if searchHistory.count > 5 {
                searchHistory.removeLast()
            }
            // Save updated history to UserDefaults or other storage
        }
    }

    extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return filteredSuggestions.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestionCell", for: indexPath)
            cell.textLabel?.text = filteredSuggestions[indexPath.row]
            return cell
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // Use suggestion selected
            let selectedQuery = filteredSuggestions[indexPath.row]
            searchBar.text = selectedQuery
            performSearch(query: selectedQuery)
        }
    }

    extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return searchResults.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchViewCell.identifier, for: indexPath) as? SearchViewCell else {
                return UICollectionViewCell()
            }
            
            cell.delegate = self
            cell.configureCell(info: detailModel)
            return cell
        }

        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            // Open detail view controller with selected item
            let detailVC = DetailViewController()
            navigationController?.pushViewController(detailVC, animated: true)
        }
}

//SearchViewCellDelegate
extension SearchViewController: SearchViewCellDelegate{
    func didTapped(_ cell: SearchViewCell) {
        print("like")
    }
    
    
}


//UITableViewCell + extension
public extension UITableViewCell {
    static var identifier: String {
        String(describing: self)
    }
}

//UICollectionViewCell + extension
public extension UICollectionViewCell {
    static var identifier: String {
        String(describing: self)
    }
}

