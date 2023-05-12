//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Кужельная Екатерина on 17.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let tabBarController = UITabBarController()
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabBarController

        coordinator = AppCoordinator(tabBarController: tabBarController)
        coordinator?.start()

        window?.makeKeyAndVisible()
    }
}

