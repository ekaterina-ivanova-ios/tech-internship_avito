//
//  ViewController.swift
//  tech-internship_avito
//
//  Created by Екатерина Иванова on 09.09.2024.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private let searchBar = UISearchBar()
    private let tipsTableView = UITableView()
//    private let resultCollectionView = UICollectionView()
    private let resultCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width/2) - 20, height: (UIScreen.main.bounds.width/2) - 20)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    lazy var listSortedButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(changeToListView), for: .touchUpInside)
        button.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        button.tintColor = .systemGray
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var panelSortedButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(changeToPanelView), for: .touchUpInside)
        button.setImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        button.tintColor = .systemGray
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let presenter: SearchPresenterProtocol
    
    init(presenter: SearchPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        presenter.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // Setup searchBar
        searchBar.delegate = self
        searchBar.placeholder = "Enters a search term..."
        searchBar.backgroundImage = UIImage()
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        //Setup panelSortedButton
        view.addSubview(panelSortedButton)
        NSLayoutConstraint.activate([
            panelSortedButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5),
            panelSortedButton.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: -5),
            panelSortedButton.widthAnchor.constraint(equalToConstant: 40),
            panelSortedButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        //Setup listSortedButton
        view.addSubview(listSortedButton)
        NSLayoutConstraint.activate([
            listSortedButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5),
            listSortedButton.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: -40),
            listSortedButton.widthAnchor.constraint(equalToConstant: 40),
            listSortedButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Setup tipsTableView
        tipsTableView.delegate = self
        tipsTableView.dataSource = self
        tipsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "SuggestionCell")
        view.addSubview(tipsTableView)
        tipsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tipsTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tipsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tipsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tipsTableView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        // Setup resultCollectionView
        resultCollectionView.delegate = self
        resultCollectionView.dataSource = self
        resultCollectionView.register(SearchViewCell.self, forCellWithReuseIdentifier: SearchViewCell.identifier)
        view.addSubview(resultCollectionView)
        resultCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resultCollectionView.topAnchor.constraint(equalTo: panelSortedButton.bottomAnchor, constant: 10),
            resultCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resultCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resultCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func updateCollection() {
        tipsTableView.isHidden = true
        resultCollectionView.isHidden = false
        resultCollectionView.reloadData()
    }
    
    
    @objc func changeToPanelView() {
        let layout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
                layout.minimumLineSpacing = 10
                layout.minimumInteritemSpacing = 10
                layout.itemSize = CGSize(width: (UIScreen.main.bounds.width/2) - 20, height: (UIScreen.main.bounds.width/2) - 20)
        
        resultCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    
    @objc func changeToListView() {
        let layout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
                layout.minimumLineSpacing = 10
                layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.width - 20)
        
        resultCollectionView.setCollectionViewLayout(layout, animated: true)
       
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        // Update suggestions based on input
        presenter.textDidChange(searchText)
//        presenter.filteredSuggestions = searchHistory.filter { $0.lowercased().contains(searchText.lowercased()) }
//        tipsTableView.isHidden = filteredSuggestions.isEmpty
        tipsTableView.isHidden = false
        self.view.bringSubviewToFront(tipsTableView)
//        tipsTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Perform search
        presenter.searchButtonClicked(searchBar.text ?? "")
//        performSearch(query: searchBar.text ?? "")
        searchBar.resignFirstResponder()
    }
    
    private func performSearch(query: String) {
        // Save to history
//        addQueryToHistory(query)
        
        // Call API to search and update `searchResults`
        
        // Reload resultCollectionView
        
        
        // Example reload
//        searchResults = [MediaContent(title: "Books", description: "Amazing stories", author: "Peter", imageUrl: "photo", id: "1"), MediaContent(title: "Books", description: "Amazing stories", author: "Peter", imageUrl: "photo", id: "1")]
//        resultCollectionView.reloadData()
    }
    
    private func addQueryToHistory(_ query: String) {
//        guard !query.isEmpty else { return }
//        if let index = searchHistory.firstIndex(of: query) {
//            searchHistory.remove(at: index)
//        }
//        searchHistory.insert(query, at: 0)
//        if searchHistory.count > 5 {
//            searchHistory.removeLast()
//        }
        // Save updated history to UserDefaults or other storage
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.filteredSuggestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestionCell", for: indexPath)
        cell.textLabel?.text = presenter.filteredSuggestions[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Use suggestion selected
//        let selectedQuery = filteredSuggestions[indexPath.row]
//        searchBar.text = selectedQuery
//        performSearch(query: selectedQuery)
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.cellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchViewCell.identifier, for: indexPath) as? SearchViewCell else {
            return UICollectionViewCell()
        }
        
        let cellModel = presenter.cellModels[indexPath.row]
        cell.delegate = self
        cell.configureCell(info: cellModel)
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

