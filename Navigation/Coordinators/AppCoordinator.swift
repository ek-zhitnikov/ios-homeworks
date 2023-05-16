//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Евгений Житников on 10.05.2023.
//


import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []

    private let tabBarController: UITabBarController

    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }

    func start() {
        let feedCoordinator = FeedCoordinator()
        let loginCoordinator = LoginCoordinator()

        childCoordinators = [feedCoordinator, loginCoordinator]

        tabBarController.viewControllers = [
            feedCoordinator.navigationController,
            loginCoordinator.navigationController
        ]
    }
}
