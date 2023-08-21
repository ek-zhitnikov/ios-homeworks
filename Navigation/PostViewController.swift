//
//  PostViewController.swift
//  Navigation
//
//  Created by Кужельная Екатерина on 17.02.2023.
//

import UIKit

class PostViewController: UIViewController {
    var post: FirstPost?
    
    init(post: FirstPost? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.post = post
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = post?.title
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
