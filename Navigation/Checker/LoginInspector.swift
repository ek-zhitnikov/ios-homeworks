//
//  LoginInspector.swift
//  Navigation
//
//  Created by Евгений Житников on 25.04.2023.
//

import Foundation

//Создайте новую структуру LoginInspector и подпишите её на протокол LoginViewControllerDelegate; сделайте в ней реализацию метода протокола
class LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        let checker = Checker.shared
        return checker.check(login: login, password: password)
    }
    
}
