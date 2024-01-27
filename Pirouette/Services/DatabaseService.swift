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
    
    func setProfile(user: MVUser, complition: @escaping (Result<MVUser, Error>) -> ()) {
        usersRef.document(user.id).setData(user.representation) {
            error in
            if let error = error {
                complition(.failure(error))
                } else {
                    complition(.success(user))
                }
        }
    }
    
    
    func getProfile(complition: @escaping (Result<MVUser, Error>) -> ()) {
        usersRef.document(AuthService.shared.currentUser!.uid).getDocument { docSnapshot, error in
            guard let snap = docSnapshot else { return }
            guard let data = snap.data() else { return }
            
            guard let userName = data["name"] as? String else { return }
            guard let id = data["id"] as? String else { return }
            guard let phone = data["phone"] as? Int else { return }
            guard let address = data["address"] as? String else { return }

            let user = MVUser(id: id, name: userName, phone: phone, address: address)
            complition(.success(user))
        }
    }
    
    
}
