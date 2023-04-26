//
//  Checker.swift
//  Navigation
//
//  Created by Евгений Житников on 25.04.2023.
//

import Foundation

class Checker {
    static let shared = Checker()

    private let login: String = "test_login"
    private let password: String = "aaa"
    
    private init() {
    }

    func check(login: String, password: String) -> Bool {
        return self.login == login && self.password == password
    }
    
}
