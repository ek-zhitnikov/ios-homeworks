//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Евгений Житников on 10.05.2023.
//


import UIKit

class FeedCoordinator: Coordinator {
    func start() {
    }
    
    var childCoordinators: [Coordinator] = []

    let navigationController: UINavigationController


    init() {
        let feedViewController = FeedViewController()
        feedViewController.title = "Feed"

        navigationController = UINavigationController(rootViewController: feedViewController)
        navigationController.tabBarItem = UITabBarItem(
            title: "Feed",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )

        feedViewController.coordinator = self
    }
    
    func showPost() {
        let secondPost = FirstPost(title: "PostViewController")
        let postVC = PostViewController()
        postVC.post = secondPost
        navigationController.pushViewController(postVC, animated: true)
    }
}
