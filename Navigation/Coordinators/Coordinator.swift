//
//  Coordinator.swift
//  Navigation
//
//  Created by Евгений Житников on 10.05.2023.
//

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}
