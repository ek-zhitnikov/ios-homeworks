//
//  FeedModel.swift
//  Navigation
//
//  Created by Евгений Житников on 03.05.2023.
//

import Foundation

class FeedModel {

    private let secretWord: String = "пароль"
    
    func check(_ word: String) -> Bool {
        word == secretWord
    }
}
