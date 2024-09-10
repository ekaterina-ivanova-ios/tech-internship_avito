//
//  DetailViewController.swift
//  tech-internship_avito
//
//  Created by Екатерина Иванова on 09.09.2024.
//

import UIKit

class DetailViewController: UIViewController, DetailViewControllerProtocol {
    
    var presenter: DetailViewPresenterProtocol?
    
    //hardCode
    var detailModel = MediaContent(
        title: "Books",
        description: "Amazing stories Amazing stories Amazing stories Amazing stories Amazing stories Amazing stories Amazing stories Amazing stories Amazing stories Amazing stories",
        author: "author: Peter",
        imageUrl: "photo1",
        id: "1")
  
    private let detailView = DetailView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.presenter = DetailViewPresenter()
        //self.presenter.detailView = DetailView()
        self.presenter?.view = self
    }
    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }

    
//MARK: DetailViewControllerProtocol
    func reloadCollectionView() {
        
    }
    
    func showErrorAlert() {
        
    }
}


//MARK: DetailViewDelegate
extension DetailViewController: DetailViewDelegate {
    
    func tappedBack() {
        
    }
    
    func tappedShare() {
        
    }
    
    func tappedDownload() {
        
    }
    
    
}

//MARK: SetupViews

extension DetailViewController {
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(detailView.mediaCover)
        view.addSubview(detailView.mediaNameLabel)
        view.addSubview(detailView.mediaDescriptionLabel)
        view.addSubview(detailView.authorLabel)
        view.addSubview(detailView.backButton)
        view.addSubview(detailView.downloadButton)
        view.addSubview(detailView.shareButton)
        setupContent(info: detailModel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
    
//mediaCover
            detailView.mediaCover.topAnchor.constraint(equalTo: view.topAnchor),
            detailView.mediaCover.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.mediaCover.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailView.mediaCover.heightAnchor.constraint(equalToConstant: 450),
//mediaNameLabel
            detailView.mediaNameLabel.topAnchor.constraint(equalTo: detailView.mediaCover.bottomAnchor, constant: 30),
            detailView.mediaNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            detailView.mediaNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
//mediaDescriptionLabel
            detailView.mediaDescriptionLabel.topAnchor.constraint(equalTo: detailView.authorLabel.bottomAnchor, constant: 30),
            detailView.mediaDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            detailView.mediaDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
//authorLabel
            detailView.authorLabel.topAnchor.constraint(equalTo: detailView.mediaNameLabel.bottomAnchor, constant: 15),
            detailView.authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
//backButton
            detailView.backButton.topAnchor.constraint(equalTo: detailView.mediaCover.topAnchor, constant: 80),
            detailView.backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailView.backButton.heightAnchor.constraint(equalToConstant: 40),
            detailView.backButton.widthAnchor.constraint(equalToConstant: 40),
//shareButton
            detailView.shareButton.bottomAnchor.constraint(equalTo: detailView.mediaCover.bottomAnchor, constant: -20),
            detailView.shareButton.trailingAnchor.constraint(equalTo: detailView.mediaCover.trailingAnchor, constant: -30),
            detailView.shareButton.heightAnchor.constraint(equalToConstant: 40),
            detailView.shareButton.widthAnchor.constraint(equalToConstant: 40),
//downloadButton
            detailView.downloadButton.bottomAnchor.constraint(equalTo: detailView.mediaCover.bottomAnchor, constant: -20),
            detailView.downloadButton.trailingAnchor.constraint(equalTo: detailView.mediaCover.trailingAnchor, constant: -90),
            detailView.downloadButton.heightAnchor.constraint(equalToConstant: 40),
            detailView.downloadButton.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func setupContent(info: MediaContent) {
        detailView.mediaCover.image = UIImage(named: info.imageUrl)
        detailView.mediaNameLabel.text = info.title
        detailView.mediaDescriptionLabel.text = info.description
        detailView.authorLabel.text = info.author
    }
}
