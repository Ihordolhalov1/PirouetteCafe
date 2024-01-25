//
//  DatabaseService.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 25.01.2024.
//

import Foundation
import FirebaseFirestore

class DatabaseService {
    static let shared = DatabaseService()
    private let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection("users")
    }  //ссылка на коллекцию пользователей
    
    private init() {
        
    }
    
    func setUser(user: MVUser, complition: @escaping (Result<MVUser, Error>) -> ()) {
        usersRef.document(user.id).setData(user.representation) {
            error in
            if let error = error {
                complition(.failure(error))
                } else {
                    complition(.success(user))
                }
        }
    }
}
