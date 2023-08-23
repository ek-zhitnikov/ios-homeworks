//
//  CheckerService.swift
//  Navigation
//
//  Created by Евгений Житников on 23.08.2023.
//

import Foundation
import FirebaseAuth

protocol CheckerServiceProtocol {
    func checkCredentials (email: String, password: String, completion: @escaping ((Result<AuthDataResult, Error>) -> Void))
    func signUp (email: String, password: String, completion: @escaping ((Result<AuthDataResult, Error>) -> Void))
}

class CheckerService: CheckerServiceProtocol {
    
    func checkCredentials(email: String, password: String, completion: @escaping ((Result<AuthDataResult, Error>) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
            <#code#>
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping ((Result<AuthDataResult, Error>) -> Void)) {
        Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
            <#code#>
        }
    }
    
}
