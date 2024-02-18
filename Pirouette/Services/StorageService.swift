//
//  StorageService.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 17.02.2024.
//

import Foundation
import FirebaseStorage

class StorageService {
    
    static let shared = StorageService()
    
   
    
    private let storage = Storage.storage()
    private let productsRef: StorageReference //{ storage.child("products") }
    private init() { productsRef = storage.reference() }
    
    
    func downloadProductImage(id: String, completion: @escaping(Result<Data, Error>) -> ()) {
        let imageRef = productsRef.child("products/\(id).jpg")
        imageRef.getData(maxSize: 10 * 1024 * 1024) { data, error in
            guard let data = data else {
                if let error = error {completion (.failure (error))}
                print("StorageService.downloadProductImage got NOT data for id: ", id)
                print(self.productsRef.child(id))
                return
            }
            print("StorageService.downloadProductImage got data, data are: ")
            print(data)
            completion(.success(data))
        }
    }
    
}

