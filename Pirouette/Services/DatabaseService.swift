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
    
    private var ordersRef: CollectionReference {
        return db.collection("orders")
    }
    
    private init() {
        
    }
    
    func getOrders(by userID: String?, completion: @escaping (Result<[Order], Error>) -> ()) {
        self.ordersRef.getDocuments { qSnap, error in
            if let qSnap = qSnap {
                var orders = [Order]()
                
                for doc in qSnap.documents {
                    if let userID = userID {
                        if let order = Order(doc: doc), order.userID == userID {
                            orders.append(order)
                        }
                    } else {
                        //ветка админа
                        if let order = Order(doc: doc) {
                            orders.append(order)
                        }
                    }
                }
                
                completion(.success(orders))
            } else if let error = error {
                completion(.failure(error))
            }
            
        }
    }
    
   

    func setOrder(order: Order, completion: @escaping (Result<Order, Error>) -> ()) {
        ordersRef.document(order.id).setData(order.representation) {
            error in
            if let error = error {
                completion(.failure(error))
                } else {
                    self.setPositions(orderId: order.id, positions: order.positions) { result in
                        switch result {
                        case .success(let positions):
                            print(positions.count)
                            completion(.success(order))
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
        }
    }
    
    func setPositions(orderId: String, positions: [Position], completion: @escaping (Result<[Position], Error>) -> ()) {
        let positionsRef = ordersRef.document(orderId).collection("positions")
        
        for position in positions {
            positionsRef.document(position.id).setData(position.representation)
        }
        completion(.success(positions))
        
    }
    
    func setProfile(user: MVUser, completion: @escaping (Result<MVUser, Error>) -> ()) {
        usersRef.document(user.id).setData(user.representation) {
            error in
            if let error = error {
                completion(.failure(error))
                } else {
                    completion(.success(user))
                }
        }
    }
    
    
    func getProfile(completion: @escaping (Result<MVUser, Error>) -> ()) {
        usersRef.document(AuthService.shared.currentUser!.uid).getDocument { docSnapshot, error in
            guard let snap = docSnapshot else { return }
            guard let data = snap.data() else { return }
            
            guard let userName = data["name"] as? String else { return }
            guard let id = data["id"] as? String else { return }
            guard let phone = data["phone"] as? Int else { return }
            guard let address = data["address"] as? String else { return }

            let user = MVUser(id: id, name: userName, phone: phone, address: address)
            completion(.success(user))
        }
    }
    
    
}
