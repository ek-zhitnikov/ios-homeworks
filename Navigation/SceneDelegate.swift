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

        let feedViewController = FeedViewController()
        feedViewController.title = "Feed"
        let feedNavigationController = UINavigationController(rootViewController: feedViewController)
        feedNavigationController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        
        let profileViewController = ProfileViewController()
        profileViewController.title = "Profile"
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        //Внедрите зависимость контроллера LoginViewController от LoginInspector, то есть присвойте значение свойству делегата в классе SceneDelegate
        let loginInspector = LoginInspector()
        let logInVС = LogInViewController()
        logInVС.loginDelegate = loginInspector
        logInVС.title = "Profile"
        let logInNavigationController = UINavigationController(rootViewController: logInVС)
        logInNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        
        let postViewController = PostViewController()
        let postNavigationController = UINavigationController(rootViewController: postViewController)
        postNavigationController.tabBarItem = UITabBarItem(title: "Post", image: UIImage(systemName: "message.fill"), selectedImage: UIImage(systemName: "message.fill"))
        

        let myPost = FirstPost(title: "New post")
        postViewController.post = myPost

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [feedNavigationController, logInNavigationController]
      


        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = tabBarController
        self.window = window
        window.makeKeyAndVisible()
    }
}
