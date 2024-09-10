//
//  CustomNavigationController.swift
//  tech-internship_avito
//
//  Created by Екатерина Иванова on 09.09.2024.
//

import UIKit

final class CustomNavigationController: UINavigationController {
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {

        if viewControllers.isEmpty {
            viewController.hidesBottomBarWhenPushed = false
        } else {
            let backButton = UIButton(type: .system)
            backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
            backButton.tintColor = .systemGray
            backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
            let backButtonBarItem = UIBarButtonItem(customView: backButton)
            viewController.navigationItem.leftBarButtonItem = backButtonBarItem
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }

    @objc private func backButtonTapped() {
        popViewController(animated: true)
    }
}
