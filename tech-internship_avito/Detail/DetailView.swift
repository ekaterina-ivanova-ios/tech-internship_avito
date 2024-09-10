//
//  DetailView.swift
//  tech-internship_avito
//
//  Created by Екатерина Иванова on 09.09.2024.
//

import UIKit

final class DetailView {
    
    lazy var mediaCover: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 40
        image.layer.masksToBounds = true
        image.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var mediaNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var mediaDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .italicSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(tappedBack), for: .touchUpInside)
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(tappedShare), for: .touchUpInside)
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var downloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(tappedDownload), for: .touchUpInside)
        button.setImage(UIImage(systemName: "arrow.down.circle"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var delegate: DetailViewDelegate?
    
    @objc private func tappedShare() {
        delegate?.tappedShare()
    }
    
    @objc private func tappedDownload() {
        delegate?.tappedDownload()
    }
    
    @objc private func tappedBack() {
        delegate?.tappedBack()
    }
  
}
