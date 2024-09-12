//
//  DetailView.swift
//  tech-internship_avito
//
//  Created by Екатерина Иванова on 09.09.2024.
//

import UIKit

final class DetailView: UIView {
    
    weak var delegate: DetailViewDelegate?
    
    private lazy var mediaCoverImageView: UIImageView = {
        var image = UIImageView()
        image.layer.cornerRadius = 40
        image.layer.masksToBounds = true
        image.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var mediaDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .italicSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
        button.setImage(Constant.ButtonImage.shareButton, for: .normal)
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var downloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(didTapDownloadButton), for: .touchUpInside)
        button.setImage(Constant.ButtonImage.downloadButton, for: .normal)
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    @objc private func didTapShareButton() {
        delegate?.didTapShareButton(image: mediaCoverImageView.image ?? UIImage())
    }
    
    @objc private func didTapDownloadButton() {
        delegate?.didTapDownloadButton(image: mediaCoverImageView.image ?? UIImage())
    }
    
    func configure(with model: PhotoCollectionCellModel) {
        mediaCoverImageView.downloadImage(from: model.imageUrl)
        authorLabel.text = model.author
        mediaDescriptionLabel.text = model.description
    }
    
    private func setupViews() {
        addSubview(mediaCoverImageView)
        addSubview(authorLabel)
        addSubview(mediaDescriptionLabel)
        addSubview(downloadButton)
        addSubview(shareButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            //mediaCover
            mediaCoverImageView.topAnchor.constraint(equalTo: topAnchor),
            mediaCoverImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mediaCoverImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            //authorLabel
            authorLabel.topAnchor.constraint(equalTo: mediaCoverImageView.bottomAnchor, constant: 15),
            authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            //mediaDescriptionLabel
            mediaDescriptionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 30),
            mediaDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            mediaDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            //shareButton
            shareButton.bottomAnchor.constraint(equalTo: mediaCoverImageView.bottomAnchor, constant: -20),
            shareButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            shareButton.heightAnchor.constraint(equalToConstant: 40),
            shareButton.widthAnchor.constraint(equalToConstant: 40),
            //downloadButton
            downloadButton.bottomAnchor.constraint(equalTo: mediaCoverImageView.bottomAnchor, constant: -20),
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -70),
            downloadButton.heightAnchor.constraint(equalToConstant: 40),
            downloadButton.widthAnchor.constraint(equalToConstant: 40),
            
        ])
    }
    
}
