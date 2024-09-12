//
//  SearchView.swift
//  tech-internship_avito
//
//  Created by Екатерина Иванова on 09.09.2024.
//

import UIKit

final class SearchViewCell: UICollectionViewCell {
    
    private lazy var mediaImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .italicSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    private func setupViews() {
        contentView.addSubview(mediaImage)
        contentView.addSubview(titleLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            //mediaImage
            mediaImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            mediaImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mediaImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            //titleLabel
            titleLabel.topAnchor.constraint(equalTo: mediaImage.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        
        ])
    }
    
    func configureCell(info: PhotoCollectionCellModel) {
        mediaImage.downloadImage(from: info.imageUrl)
        titleLabel.text = info.description
    }
}
