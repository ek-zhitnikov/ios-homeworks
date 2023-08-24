//
//  LoginInspector.swift
//  Navigation
//
//  Created by Евгений Житников on 25.04.2023.
//

import Foundation
import FirebaseAuth

protocol LoginViewControllerDelegate {
    func checkCredentials (email: String, password: String, completion: @escaping ((Result<AuthDataResult, Error>) -> Void))
    func signUp (email: String, password: String, completion: @escaping ((Result<AuthDataResult, Error>) -> Void))
    
}

struct LoginInspector: LoginViewControllerDelegate {
    func checkCredentials(email: String, password: String, completion: @escaping ((Result<AuthDataResult, Error>) -> Void)) {
        CheckerService().checkCredentials(email: email, password: password) { result in
            completion(result)
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping ((Result<AuthDataResult, Error>) -> Void)) {
        CheckerService().signUp(email: email, password: password) { result in
            completion(result)
        }
    }
}
