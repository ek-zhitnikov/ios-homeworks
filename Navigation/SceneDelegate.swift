//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Кужельная Екатерина on 17.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        //добавьте UITabBarController
        let tabBarController = UITabBarController()
        
        let feedViewController = FeedViewController()
        let profileViewController = ProfileViewController()
        
        let feedNavigationController = UINavigationController(rootViewController: feedViewController)
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        
        //Измените Tab Bar Item у добавленных контроллеров, добавьте заголовок и картинку
        feedNavigationController.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "hoyse.fill"))

        profileNavigationController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))

        //Создайте FeedViewController и ProfileViewController и добавьте их как root view controller у навигационных контроллеров.

        tabBarController.viewControllers = [feedNavigationController, profileNavigationController]
        
        
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = tabBarController
        
        self.window = window
        window.makeKeyAndVisible()
        
    }
}
