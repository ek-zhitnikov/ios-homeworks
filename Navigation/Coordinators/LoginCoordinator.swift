//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by Евгений Житников on 10.05.2023.
//

import UIKit

class LoginCoordinator: Coordinator {
    func start() {
    }
    
    var childCoordinators: [Coordinator] = []

    let navigationController: UINavigationController

    init() {
        let loginViewController = LogInViewController()
        loginViewController.title = "Profile"

        navigationController = UINavigationController(rootViewController: loginViewController)
        navigationController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
        let loginFactory = MyLoginFactory()
        
        let loginInspector = loginFactory.makeLoginInspector()
        loginViewController.loginDelegate = loginInspector
        
        loginViewController.coordinator = self
    }
}
