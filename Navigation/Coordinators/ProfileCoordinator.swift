//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Евгений Житников on 12.05.2023.
//

import UIKit

class ProfileCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []

    let navigationController: UINavigationController

    init(_ user: User, navigationController: UINavigationController) {
        self.navigationController = navigationController
        let profileViewController = ProfileViewController()
        profileViewController.user = user
        profileViewController.coordinator = self
        navigationController.pushViewController(profileViewController, animated: true)
    }

    func start() {
    }
}








