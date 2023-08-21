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

//        // Рандомно инициализируем свойство appConfiguration
//        let configurations: [AppConfiguration] = [
//            .people("https://swapi.dev/api/people/1"),
//            .starships("https://swapi.dev/api/starships/3"),
//            .planets("https://swapi.dev/api/planets/2")
//        ]
//
//       let appConfiguration = configurations.randomElement()!
//
//        // Передаем конфигурацию в метод сетевого сервиса
//        NetworkService.request(for: appConfiguration)
        
        window?.makeKeyAndVisible()
    }
}

