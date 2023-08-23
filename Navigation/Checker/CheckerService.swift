//
//  CheckerService.swift
//  Navigation
//
//  Created by Евгений Житников on 23.08.2023.
//

import Foundation
import FirebaseAuth


enum LoginErrors: Error {
    case authResultIsNil
}

protocol CheckerServiceProtocol {
    func checkCredentials (email: String, password: String, completion: @escaping ((Result<AuthDataResult, Error>) -> Void))
    func signUp (email: String, password: String, completion: @escaping ((Result<AuthDataResult, Error>) -> Void))
}

class CheckerService: CheckerServiceProtocol {
    
    func checkCredentials(email: String, password: String, completion: @escaping ((Result<AuthDataResult, Error>) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
            if let error {
                completion(.failure(error))
                return
            }

            guard let result = authDataResult else {
                completion(.failure(LoginErrors.authResultIsNil))
                return
            }

            completion(.success(result))
        
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping ((Result<AuthDataResult, Error>) -> Void)) {
        Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
            if let error {
                completion(.failure(error))
                return
            }

            guard let result = authDataResult else {
                completion(.failure(LoginErrors.authResultIsNil))
                return
            }

            completion(.success(result))
        
        }
    }
    
}
