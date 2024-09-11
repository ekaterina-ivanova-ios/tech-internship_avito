//
//  DetailViewController.swift
//  tech-internship_avito
//
//  Created by Екатерина Иванова on 09.09.2024.
//

import UIKit

class DetailViewController: UIViewController, DetailViewControllerProtocol {
    
    private let presenter: DetailViewPresenterProtocol
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.horizontalScrollIndicatorInsets = .zero
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var detailView: DetailView = {
        let view = DetailView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(presenter: DetailViewPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.backgroundColor = UIColor.clear
            appearance.shadowColor = UIColor.clear
            
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance

    }
    
    func update(with model: PhotoCollectionCellModel) {
        detailView.configure(with: model)
    }
    
    //MARK: DetailViewControllerProtocol
    func reloadCollectionView() {
        
    }
    
    func showErrorAlert() {
        
    }
}


//MARK: DetailViewDelegate
extension DetailViewController: DetailViewDelegate {
    
    func didTapShareButton(image: UIImage) {
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    
    func didTapDownloadButton(image: UIImage) {
        image.saveImageToPhotosAlbum()
    }
    
}

//MARK: SetupViews

extension DetailViewController {
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(detailView)
        setupConstraints()
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            
            detailView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            detailView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            detailView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
        ])
    }
    
}
