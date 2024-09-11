//
//  ErrorView.swift
//  tech-internship_avito
//
//  Created by Екатерина Иванова on 11.09.2024.
//

import UIKit

struct ErrorViewModel {
    let errorMessage: String
    let retryAction: () -> Void
}

final class ErrorView: UIView {

    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray3
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let retryButton: UIButton = {
        let button = UIButton()
        button.setTitle("Retry", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let errorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "exclamationmark.triangle.fill")
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let viewModel: ErrorViewModel

    init(viewModel: ErrorViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupView()
        setRetryAction()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .white
        errorLabel.text = viewModel.errorMessage
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0

        addSubview(errorLabel)
        addSubview(retryButton)
        addSubview(errorImageView)
        
        NSLayoutConstraint.activate([
            errorImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            errorImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            errorImageView.widthAnchor.constraint(equalToConstant: 60),
            errorImageView.heightAnchor.constraint(equalToConstant: 60),
            
            errorLabel.topAnchor.constraint(equalTo: errorImageView.bottomAnchor, constant: 16),
            errorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            errorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),

            retryButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 16),
            retryButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            retryButton.widthAnchor.constraint(equalToConstant: 100),
            retryButton.heightAnchor.constraint(equalToConstant: 44),
            retryButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setRetryAction() {
        retryButton.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
    }
    
    @objc private func retryButtonTapped() {
        viewModel.retryAction()
    }
}

