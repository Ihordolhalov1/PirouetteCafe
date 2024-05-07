//
//  AuthService.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 23.01.2024.
//

import Foundation
import FirebaseAuth

class AuthService {
    
    static let shared = AuthService()
    
    private init() {
        
        
    }
    
    private let auth = Auth.auth()
    
    var currentUser: User? {
        return auth.currentUser
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<User, Error>) -> ()) { //создать DetailedUser
        auth.createUser(withEmail: email, password: password) { result, error in
            if let result = result {
                let mwUser = DetailedUser(id: result.user.uid, name: "New user", phone: "", address: "Address of new user", token: deviceToken)
                print("Відпрацював метод signUp")
                DatabaseService.shared.setProfile(user: mwUser) { resultDB in
                    switch resultDB {
                    case .success(_):
                        completion(.success(result.user))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> ()) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let result = result {
                print("Відпрацював метод signIn")
                print("Tокен: ", deviceToken)
                completion(.success(result.user))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    
    func signOut() {
       try! auth.signOut()
    }
    
    func resetPassword(email: String, completion: @escaping (Result<User, Error>) -> ()) {
        auth.sendPasswordReset(withEmail: email) { error in
             if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    
}
