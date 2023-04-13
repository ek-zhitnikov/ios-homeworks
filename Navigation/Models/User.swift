//
//  User.swift
//  Navigation
//
//  Created by Евгений Житников on 13.04.2023.
//

import Foundation
import UIKit


// Класс User для хранения информации о пользователе
class User {
    var login: String
    var fullName: String
    var avatar: UIImage
    var status: String
    
    init(login: String, fullName: String, avatar: UIImage, status: String) {
        self.login = login
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
}

// Протокол UserService
protocol UserService {
    func getUser(byLogin login: String) -> User?
}

// Класс CurrentUserService, поддерживающий протокол UserService
class CurrentUserService: UserService {
    var currentUser: User
    
    init(currentUser: User) {
        self.currentUser = currentUser
    }
    
    func getUser(byLogin login: String) -> User? {
        guard login == currentUser.login else {
            return nil
        }
        return currentUser
    }
}

