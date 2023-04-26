//
//  LoginFactory.swift
//  Navigation
//
//  Created by Евгений Житников on 25.04.2023.
//

import Foundation

//Создайте новый протокол LoginFactory с одним методом без параметров makeLoginInspector, который будет возвращать LoginInspector
protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}

//Сделайте новую структуру MyLoginFactory, которая будет удовлетворять требованиям протокола LoginFactory и содержать генератор экземпляра LoginInspector
struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}
