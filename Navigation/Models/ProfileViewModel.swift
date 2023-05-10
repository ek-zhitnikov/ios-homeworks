//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Евгений Житников on 04.05.2023.
//

import Foundation
import StorageService

class ProfileViewModel {
    var modelPosts: [Post] = []

    func fetchPosts() {
        //загружаем данные из модели
        self.modelPosts = posts
    }
}
