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
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .darkGray
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var tableViewHeightConstraint = tipsTableView.heightAnchor.constraint(equalToConstant: 0)
    private var errorView: ErrorView?
    
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
        self.title = "SearchPage"
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

        setupActivityIndicator()
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func showError(viewModel: ErrorViewModel) {
        errorView = ErrorView(viewModel: viewModel)
        guard let errorView else {
            return
        }
        view.addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 50)
        ])
    }
    
    private func hideError() {
        errorView?.removeFromSuperview()
        errorView = nil
    }
    
    private func updateTableViewHeight() {
        tipsTableView.layoutIfNeeded()
        tableViewHeightConstraint.constant = tipsTableView.contentSize.height
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

extension SearchViewController: SearchViewControllerProtocol {
    
    func updateCollection() {
        tipsTableView.isHidden = true
        resultCollectionView.isHidden = false
        resultCollectionView.reloadData()
    }
    
    func updateTipsTableView() {
        tipsTableView.isHidden = false
        view.bringSubviewToFront(tipsTableView)
        tipsTableView.reloadData()
        updateTableViewHeight()
    }
    
    func updateSearchBarText(_ text: String) {
        searchBar.text = text
    }
    
    func updateState(_ state: SearchState) {
        hideError()
        switch state {
        case .loading:
            tipsTableView.isHidden = true
            resultCollectionView.isHidden = true
            activityIndicator.startAnimating()
        case .error(let viewModel):
            activityIndicator.stopAnimating()
            showError(viewModel: viewModel)
        case .default:
            resultCollectionView.isHidden = false
            activityIndicator.stopAnimating()
        }
        
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.textDidChange(searchText)
        tipsTableView.isHidden = false
        view.bringSubviewToFront(tipsTableView)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchButtonClicked(searchBar.text ?? "")
        searchBar.resignFirstResponder()
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
        presenter.didSelectTip(at: indexPath)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
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
        let model = presenter.cellModels[indexPath.row]
        let detailVC = ModuleAssembly.makeDetailModule(model)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

//SearchViewCellDelegate
extension SearchViewController: SearchViewCellDelegate{
    func didTapped(_ cell: SearchViewCell) {
        print("like")
    }
    
}
