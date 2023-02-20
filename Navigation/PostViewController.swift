//
//  PostViewController.swift
//  Navigation
//
//  Created by Кужельная Екатерина on 17.02.2023.
//

import UIKit

class PostViewController: UIViewController {
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let infoButton = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(infoButtonTapped))
        navigationItem.rightBarButtonItem = infoButton

        view.backgroundColor = .systemYellow
    }
    
    @objc func infoButtonTapped() {
        let infoViewController = InfoViewController()
        let navController = UINavigationController(rootViewController: infoViewController)
        navController.modalPresentationStyle = .pageSheet
        present(navController, animated: true, completion: nil)
    }
}
